//
//  BookingViewModel.swift
//  MegaBox
//
//  Created by 김도연 on 10/13/25.
//

import SwiftUI
import Observation
import Combine

class BookingViewModel: ObservableObject {
    //영화 선택 관련
    @Published var selectedMovie: Movie?
    @Published var selectedTheaters: Set<Theater> = []
    //영화 검색 관련
    @Published var query: String = ""
    @Published var results: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var bag = Set<AnyCancellable>()
    
    var moiveList: [Movie] = [
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
        ),
        ScreeningSchedule(
            branch: "신촌",
            theaters: [
                Theaters(
                    theaterName: "크리클라이너 3관",
                    screenType: "2D",
                    times: [
                        Screening(startTime: "11:30", endTime: "13:58", availableSeats: 109, totalSeats: 116),
                        Screening(startTime: "14:20", endTime: "16:48", availableSeats: 19, totalSeats: 116),
                        Screening(startTime: "17:05", endTime: "19:28", availableSeats: 1, totalSeats: 116),
                    ]
                ),
                Theaters(
                    theaterName: "크리클라이너 7관",
                    screenType: "2D",
                    times: [
                        Screening(startTime: "9:30", endTime: "11:50", availableSeats: 75, totalSeats: 116),
                        Screening(startTime: "14:45", endTime: "17:04", availableSeats: 88, totalSeats: 116)
                    ]
                )
            ]
        )
    ]
    
    init() {
        results = moiveList
        
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
            })
            .flatMap { query in
                self.search(query: query)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let err) = completion {
                    self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                    self?.results = []
                }
            } receiveValue: { [weak self] items in
                self?.results = items
            }
            .store(in: &bag)
    }

    private func search(query: String) -> AnyPublisher<[Movie], Error> {
        return Future<[Movie], Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            guard let self else { return }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                // 검색어가 비어있으면 전체 목록, 아니면 필터링
                let filtered = query.isEmpty ?
                self.moiveList :
                self.moiveList.filter { $0.title.lowercased().contains(query.lowercased()) }
                promise(.success(filtered))
            }
        }
        .handleEvents(
            receiveSubscription: { _ in
                DispatchQueue.main.async {
                    self.isLoading = true
                }
            },
            receiveCompletion: { _ in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        )
        .eraseToAnyPublisher()
    }
}
