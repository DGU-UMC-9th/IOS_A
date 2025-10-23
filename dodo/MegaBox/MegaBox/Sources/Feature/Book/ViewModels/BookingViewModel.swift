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
    
    // MARK: - Init
    init() {
        results = movieList
        setupBindings()
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
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } // 공백 제거
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
                self?.isLoading = true
            })
            .flatMap { [weak self] query -> AnyPublisher<[Movie], Error> in //이중 래핑 방지 Publisher<Future<[Movie], Error>, Never> -> Publisher<[Movie], Error>
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
        guard movie != nil,
              !theaters.isEmpty,
              Calendar.current.isDateInToday(date) else {
            return []
        }
        
        let theaterTitles = Set(theaters.map { $0.title })
        return screeningSchedules.filter { schedule in
            theaterTitles.contains(schedule.branch)
        }
    }
    
    // MARK: - Reset Logic
    private func setupResetLogic() {
        $selectedMovie
            .dropFirst()
            .sink { [weak self] _ in
                self?.selectedTheaters = []
                self?.selectedDate = Date()
            }
            .store(in: &bag)
    }
    
    // MARK: - Search Logic
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
                ? self.movieList
                : self.movieList.filter {
                    $0.title.localizedCaseInsensitiveContains(query)
                }
                promise(.success(filtered))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func handleSearchError(_ error: Error) {
        errorMessage = "검색 중 오류가 발생했습니다"
        results = movieList // 전체 목록 유지
        isLoading = false
    }
    
    var movieList: [Movie] = [
        Movie(posterImage: Image(.poster1), title: "어쩔수가없다", ageRating: 15),
        Movie(posterImage: Image(.poster2), title: "귀멸의칼날:무한성편", ageRating: 15),
        Movie(posterImage: Image(.poster3), title: "F1:더 무비", ageRating: 12),
        Movie(posterImage: Image(.poster4), title: "얼굴", ageRating: 15),
        Movie(posterImage: Image(.poster5), title: "모모노키 히메", ageRating: 7),
        Movie(posterImage: Image(.poster6), title: "보스", ageRating: 12),
        Movie(posterImage: Image(.poster7), title: "야당", ageRating: 12),
        Movie(posterImage: Image(.poster8), title: "The Roses", ageRating: 12),
    ]
    
    var screeningSchedules: [ScreeningSchedule] = [
        ScreeningSchedule(
            branch: "강남",
            theaters: [
                Theaters(
                    theaterName: "크리클라이너 1관",
                    screenType: "2D",
                    times: [
                        Screening(startTime: "11:30", endTime: "13:58", availableSeats: 109, totalSeats: 116),
                        Screening(startTime: "14:20", endTime: "16:48", availableSeats: 19, totalSeats: 116),
                        Screening(startTime: "17:05", endTime: "19:28", availableSeats: 1, totalSeats: 116),
                        Screening(startTime: "19:45", endTime: "22:02", availableSeats: 100, totalSeats: 116),
                        Screening(startTime: "22:20", endTime: "00:04", availableSeats: 116, totalSeats: 116)
                    ]
                ),
                Theaters(
                    theaterName: "크리클라이너 2관",
                    screenType: "2D",
                    times: [
                        Screening(startTime: "9:30", endTime: "11:50", availableSeats: 75, totalSeats: 116),
                        Screening(startTime: "12:00", endTime: "14:26", availableSeats: 102, totalSeats: 116),
                        Screening(startTime: "14:45", endTime: "17:04", availableSeats: 88, totalSeats: 116)
                    ]
                )
            ]
        ),
        ScreeningSchedule(
            branch: "홍대",
            theaters: [
                Theaters(
                    theaterName: "BTS관 (7층 1관 [Laser])",
                    screenType: "2D",
                    times: [
                        Screening(startTime: "11:30", endTime: "13:58", availableSeats: 109, totalSeats: 116),
                        Screening(startTime: "22:20", endTime: "00:04", availableSeats: 116, totalSeats: 116)
                    ]
                ),
                Theaters(
                    theaterName: "BTS관 (9층 2관 [Laser])",
                    screenType: "2D",
                    times: [
                        Screening(startTime: "9:30", endTime: "11:50", availableSeats: 75, totalSeats: 116),
                        Screening(startTime: "14:45", endTime: "17:04", availableSeats: 88, totalSeats: 116)
                    ]
                )
            ]
        )
    ]
    
}
