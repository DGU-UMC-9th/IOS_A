//
//  BookingViewModel.swift
//  MegaBox
//
//  Created by 김도연 on 10/13/25.
//

import SwiftUI
import Combine

class BookingViewModel: ObservableObject {
    //상수 enum
    private enum Constants {
        static let searchDebounceInterval = 400
        static let minSearchDelayMs = 300
        static let maxSearchDelayMs = 700
    }
    //영화 선택 관련
    @Published var selectedMovie: Movie?
    @Published var selectedTheaters: Set<Theater> = []
    @Published var selectedDate: Date = Date()
    
    //영화 검색 관련
    @Published var query: String = ""
    @Published var results: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // 활성화 상태
    @Published var isTheaterSelectionEnabled = false
    @Published var isDateSelectionEnabled = false
    @Published var filteredSchedules: [ScreeningSchedule] = []
    
    private var bag = Set<AnyCancellable>()
    
    // 영화 목록
    @Published var movies: [Movie] = []
    
    // 포스터 이미지 매핑
    private let posterImages: [String: Image] = [
        "어쩔수가없다": Image(.poster1),
        "귀멸의 칼날: 무한성": Image(.poster2),
        "F1 더 무비": Image(.poster3),
        "얼굴": Image(.poster4),
        "모모노키 히메": Image(.poster5),
        "보스": Image(.poster6),
        "야당": Image(.poster7),
        "The Roses": Image(.poster8),
    ]
    
    // MARK: - Init
    init() {
        setupBindings()
        Task {
            await fetchMovieSchedule()
        }
    }
    
    private func setupBindings() {
        setupSearchBinding()
        setupSelectionBindings()
        setupScheduleFiltering()
        setupResetLogic()
    }
    
    // MARK: - Search Binding
    private func setupSearchBinding() {
        $query
            .dropFirst()
            .debounce(for: .milliseconds(Constants.searchDebounceInterval), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
                self?.isLoading = true
            })
            .flatMap { [weak self] query -> AnyPublisher<[Movie], Error> in
                guard let self = self else {
                    return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
                }
                return self.search(query: query)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.handleSearchError(error)
                }
            } receiveValue: { [weak self] items in
                self?.results = items
                self?.isLoading = false
            }
            .store(in: &bag)
    }
    
    // MARK: - Selection Bindings
    private func setupSelectionBindings() {
        // 영화 선택 시 극장 선택 활성화
        $selectedMovie
            .map { $0 != nil }
            .assign(to: &$isTheaterSelectionEnabled)
        
        // 극장 선택 시 날짜 선택 활성화
        $selectedTheaters
            .map { !$0.isEmpty }
            .assign(to: &$isDateSelectionEnabled)
    }
    
    // MARK: - Schedule Filtering
    private func setupScheduleFiltering() {
        Publishers.CombineLatest3($selectedMovie, $selectedTheaters, $selectedDate)
            .map { [weak self] movie, theaters, date -> [ScreeningSchedule] in
                guard let self = self else { return [] }
                return self.filterSchedules(movie: movie, theaters: theaters, date: date)
            }
            .assign(to: &$filteredSchedules)
    }
    
    private func filterSchedules(movie: Movie?, theaters: Set<Theater>, date: Date) -> [ScreeningSchedule] {
        guard let movie = movie,
              !theaters.isEmpty else {
            return []
        }
        
        // 날짜 포맷터
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        let theaterTitles = Set(theaters.map { $0.title })
        
        // 선택된 영화의 스케줄에서 필터링
        return movie.schedules.filter { schedule in
            schedule.date == dateString && theaterTitles.contains(schedule.branch)
        }
    }
    
    // MARK: - Reset
    private func setupResetLogic() {
        $selectedMovie
            .dropFirst()
            .sink { [weak self] _ in
                self?.selectedTheaters = []
                self?.selectedDate = Date()
            }
            .store(in: &bag)
    }
    
    // MARK: - Search
    private func search(query: String) -> AnyPublisher<[Movie], Error> {
        return Future<[Movie], Error> { [weak self] promise in
            guard let self = self else {
                promise(.success([]))
                return
            }
            
            let delay = Double.random(
                in: Double(Constants.minSearchDelayMs)...Double(Constants.maxSearchDelayMs)
            ) / 1000.0
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let filtered = query.isEmpty
                ? self.movies
                : self.movies.filter {
                    $0.title.localizedCaseInsensitiveContains(query)
                }
                promise(.success(filtered))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Fetch Movie Schedule
    func fetchMovieSchedule() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        guard let url = Bundle.main.url(
            forResource: "MovieSchedule", withExtension: "json") else {
            await MainActor.run {
                self.errorMessage = "영화 스케줄 파일을 찾을 수 없습니다."
                self.isLoading = false
            }
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            await MainActor.run {
                self.errorMessage = "영화 스케줄 파일을 읽을 수 없습니다."
                self.isLoading = false
            }
            return
        }
        
        do {
            let response = try JSONDecoder().decode(BookingResponse.self, from: data)
            
            guard let moviesDTO = response.data?.movies else {
                await MainActor.run {
                    isLoading = false
                }
                return
            }
            
            await MainActor.run {
                // 영화 목록 매핑 및 포스터 이미지 추가
                self.movies = moviesDTO.map { dto in
                    var movie = MovieDTOMapper.toDomain(from: dto)
                    movie.posterImage = posterImages[dto.title]
                    return movie
                }
                self.results = self.movies
                self.isLoading = false
            }
        } catch {
            print("Decoding error:", error)
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
    
    // MARK: - Error Handling
    private func handleSearchError(_ error: Error) {
        errorMessage = "검색 중 오류가 발생했습니다."
        isLoading = false
    }
}
