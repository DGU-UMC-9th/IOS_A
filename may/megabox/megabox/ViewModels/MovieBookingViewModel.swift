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
    // 🔧 수정: private(set) 제거
    @Published var schedulesToShow: [Theater: [ScreeningSchedule]] = [:]
    
    // ✅ 영화 목록
    let movieList: [MovieBooking] = [
        MovieBooking(posterImage: Image(.movie1), title: "어쩔수가없다", ageRating: "15"),
        MovieBooking(posterImage: Image(.movie2), title: "극장판 귀멸의 칼날: 무한성 편", ageRating: "15"),
        MovieBooking(posterImage: Image(.movie3), title: "F1: 더 무비", ageRating: "15"),
        MovieBooking(posterImage: Image(.movie4), title: "얼굴", ageRating: "15"),
        MovieBooking(posterImage: Image(.movie5), title: "모노노케 히메", ageRating: "ALL"),
        MovieBooking(posterImage: Image(.movie6), title: "야당", ageRating: "15"),
        MovieBooking(posterImage: Image(.movie7), title: "보스", ageRating: "15"),
        MovieBooking(posterImage: Image(.movie8), title: "THE ROSES", ageRating: "15")
    ]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
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
        
        // 🔧 수정: 영화 변경 시 극장/날짜 초기화 (UX에 따라 제거 가능)
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
                // 🔧 수정: 날짜를 실제로 활용
                self.schedulesToShow = self.getSchedules(for: movie, theaters: theaters, date: date)
            }
            .store(in: &cancellables)
    }
    
    func resetSelection() {
        selectedMovie = nil
        selectedTheaters = []
        selectedDate = Date()
        schedulesToShow = [:]
    }
    
    private func getSchedules(for movie: MovieBooking, theaters: Set<Theater>, date: Date) -> [Theater: [ScreeningSchedule]] {
        var schedules: [Theater: [ScreeningSchedule]] = [:]
        
        // 임시
        let isToday = Calendar.current.isDateInToday(date)
        
        for theater in theaters {
            schedules[theater] = isToday ? createDummySchedule(for: theater) : []
        }
        return schedules
    }
    
    private func createDummySchedule(for theater: Theater) -> [ScreeningSchedule] {
        return [
            ScreeningSchedule(
                theaterName: "\(theater.title) 1관",
                screenType: "2D",
                times: [
                    ScreeningTime(startTime: "11:30", endTime: "13:58", availableSeats: 109, totalSeats: 116),
                    ScreeningTime(startTime: "14:20", endTime: "16:48", availableSeats: 19, totalSeats: 116),
                    ScreeningTime(startTime: "17:05", endTime: "19:28", availableSeats: 1, totalSeats: 116),
                    ScreeningTime(startTime: "19:45", endTime: "22:02", availableSeats: 100, totalSeats: 116),
                    ScreeningTime(startTime: "22:20", endTime: "00:04", availableSeats: 116, totalSeats: 116)
                ]
            ),
            ScreeningSchedule(
                theaterName: "\(theater.title) 2관",
                screenType: "Laser",
                times: [
                    ScreeningTime(startTime: "09:30", endTime: "11:50", availableSeats: 75, totalSeats: 116),
                    ScreeningTime(startTime: "12:00", endTime: "14:26", availableSeats: 102, totalSeats: 116),
                    ScreeningTime(startTime: "14:45", endTime: "17:04", availableSeats: 88, totalSeats: 116)
                ]
            )
        ]
    }
}
