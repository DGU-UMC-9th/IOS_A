//
//  MovieBookingViewModel.swift
//  megabox
//
//  Created by 백지은 on 10/11/25.
//

import SwiftUI
import Observation
import Combine

final class MovieBookingViewModel: ObservableObject {
    // ✅ 상태
    @Published var selectedMovie: MovieBooking? = nil
    @Published var selectedTheaters: Set<Theater> = []
    @Published var selectedDate: Date = Date()
    
    // ✅ UI 상태 제어
    @Published private(set) var canSelectTheater: Bool = false
    @Published private(set) var canSelectDate: Bool = false
    @Published private(set) var shouldShowSchedule: Bool = false
    @Published private(set) var isSelectedDateToday: Bool = true
    @Published var schedulesToShow: [Theater: [ScreeningSchedule]] = [:]
    
    @Published var movieList: [MovieBooking] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // ✅ 스케줄 정보를 포함한 DTO 데이터 보관
    private var movieDTOs: [MovieDTO] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
        loadMoviesFromJSON()
    }
    
    private func setupBindings() {
        // 영화 선택 → 극장 선택 가능
        $selectedMovie
            .map { $0 != nil }
            .assign(to: &$canSelectTheater)
        
        // 극장 선택 → 날짜 선택 가능
        $selectedTheaters
            .map { !$0.isEmpty }
            .assign(to: &$canSelectDate)
        
        // 영화 + 극장 선택 시 스케줄 표시
        Publishers.CombineLatest($selectedMovie, $selectedTheaters)
            .map { movie, theaters in
                movie != nil && !theaters.isEmpty
            }
            .assign(to: &$shouldShowSchedule)
        
        // 날짜가 오늘인지 판별
        $selectedDate
            .map { Calendar.current.isDateInToday($0) }
            .assign(to: &$isSelectedDateToday)
        
        // 영화 변경 시 극장/날짜 초기화
        $selectedMovie
            .dropFirst()
            .sink { [weak self] _ in
                self?.selectedTheaters = []
                self?.selectedDate = Date()
            }
            .store(in: &cancellables)
        
        // 영화/극장/날짜 변경 시 스케줄 업데이트
        Publishers.CombineLatest3($selectedMovie, $selectedTheaters, $selectedDate)
            .sink { [weak self] movie, theaters, date in
                guard let self = self else { return }
                guard let movie = movie, !theaters.isEmpty else {
                    self.schedulesToShow = [:]
                    return
                }
                // 날짜를 실제로 활용
                self.schedulesToShow = self.getSchedules(for: movie, theaters: theaters, date: date)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - JSON Loading
    private func loadMoviesFromJSON() {
        isLoading = true
        errorMessage = nil
        
        // 백그라운드 스레드에서 JSON 로드
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            do {
                guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") else {
                    throw MovieLoadError.fileNotFound
                }
                
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder.movieScheduleDecoder
                let apiResponse = try decoder.decode(ApiResponse.self, from: data)
                
                guard let movieDTOs = apiResponse.data?.movies, !movieDTOs.isEmpty else {
                    throw MovieLoadError.emptyData
                }
                
                let domainMovies = movieDTOs.map { $0.toDomain() }
                
                DispatchQueue.main.async {
                    self.movieDTOs = movieDTOs
                    self.movieList = domainMovies
                    self.isLoading = false
                }
                
            } catch let error as MovieLoadError {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                    print("영화 로드 에러: \(error.localizedDescription)")
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "알 수 없는 오류가 발생했습니다: \(error.localizedDescription)"
                    self.isLoading = false
                    print("에러: \(error)")
                }
            }
        }
    }
    
    // MARK: - Schedule Filtering
    private func getSchedules(for movie: MovieBooking, theaters: Set<Theater>, date: Date) -> [Theater: [ScreeningSchedule]] {
        guard let movieDTO = movieDTOs.first(where: { $0.id == movie.id }) else {
            print("영화를 찾을 수 없음: \(movie.id)")
            return [:]
        }
        
        var result: [Theater: [ScreeningSchedule]] = [:]
        
        // 선택한 날짜와 일치하는 스케줄 필터링
        for schedule in movieDTO.schedules {
            // 날짜 비교
            guard Calendar.current.isDate(schedule.date, inSameDayAs: date) else {
                continue
            }
            
            // 극장 필터링
            for area in schedule.areas {
                guard let theater = Theater(rawValue: area.area),
                      theaters.contains(theater) else {
                    continue
                }
                
                // DTO → Domain 변환
                let screeningSchedules = area.items.map {
                    $0.toDomain(area: theater.title)
                }
                
                result[theater, default: []].append(contentsOf: screeningSchedules)
            }
        }
        return result
    }
    
    // MARK: - Actions
    func resetSelection() {
        selectedMovie = nil
        selectedTheaters = []
        selectedDate = Date()
        schedulesToShow = [:]
    }
}

// MARK: - Error Handling
enum MovieLoadError: LocalizedError {
    case fileNotFound
    case emptyData
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "json 파일을 찾을 수 없습니다."
        case .emptyData:
            return "데이터가 비어있습니다."
        case .decodingFailed:
            return "JSON 데이터를 읽는데 실패했습니다."
        }
    }
}
