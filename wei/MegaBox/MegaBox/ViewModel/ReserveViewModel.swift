//
//  ReserveViewModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/12/25.
//

import Foundation
import Combine
import SwiftUI

final class ReserveViewModel: ObservableObject {

    struct Showtimes: Identifiable, Hashable {
        let id: UUID
        let theater: TheaterModel
        let times: [ScreeningModel]
    }

    
    @Published private(set) var movies: [MovieModel] = [
        .init(name:"어쩔수가 없다", imageName: "djWjftnrk", audience:"20만", age:15),
        .init(name:"극장판 귀멸의 칼날", imageName:"infinityCastle", audience:"60만",age:15),
        .init(name:"F1: 더 무비", imageName: "f1" , audience:"10만",age:12),
        .init(name:"보스", imageName: "boss" , audience:"30만",age:15),
        .init(name:"모노노케 히메", imageName: "mononoke" , audience:"40만",age:12),
        .init(name:"야당", imageName: "yaDang" , audience:"50만",age:18),
        .init(name:"얼굴", imageName: "face" , audience:"70만",age:12),
        .init(name:"the Roses", imageName: "theRoses" , audience:"80만",age:15)
    ]

    let theaters: [TheaterModel] = [
        .init(name: "크리리클라이너 1관", region: "강남"),
        .init(name: "BTS관 (7층 1관 [Laser])",   region: "홍대"),
        .init(name: "BTS관 (9층 2관 [Laser])",  region: "홍대"),
        .init(name: "3관", region: "신촌")
    ]

    @Published private(set) var screenings: [ScreeningModel] = []
    @Published var calendarViewModel = CalendarViewModel()
    @Published var selectedMovie: MovieModel? = nil
    @Published var selectedRegions: Set<String> = []
    @Published var selectedDate: Date? = Date()

    @Published private(set) var filteredShowtimes: [Showtimes] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var bag = Set<AnyCancellable>()

   
    var regions: [String] {
        Array(Set(theaters.compactMap { $0.region })).sorted()
    }

    func isRegionSelected(_ region: String) -> Bool { selectedRegions.contains(region) }
    func toggleRegion(_ region: String) {
        if selectedRegions.contains(region) { selectedRegions.remove(region) }
        else { selectedRegions.insert(region) }
    }

    
    init() {
        self.screenings = Self.createDummyScreenings(movies: movies, theaters: theaters)
        self.selectedMovie = movies.first
        pipeline()
    }

    
    private func pipeline() {
        Publishers.CombineLatest3($selectedMovie, $selectedRegions, $selectedDate)
            .sink { [weak self] (movie, regions, date) in
                self?.filterShowtimes(movie: movie, regions: regions, date: date)
            }
            .store(in: &bag)
    }

   
    private func filterShowtimes(
        movie: MovieModel?,
        regions: Set<String>,
        date: Date?
    ) {
        guard let movie = movie, let date = date else {
            filteredShowtimes = []
            return
        }

        let allowedTheaters: [TheaterModel] =
            regions.isEmpty
            ? theaters
            : theaters.filter { th in
                guard let r = th.region else { return false }
                return regions.contains(r)
            }

        var result: [Showtimes] = []

        for th in allowedTheaters {
            let times = screenings
                .filter { s in
                    s.movieId == movie.id &&
                    s.theaterId == th.id &&
                    Calendar.current.isDate(s.startAt, inSameDayAs: date)
                }
                .sorted { $0.startAt < $1.startAt }

            if !times.isEmpty {
                result.append(.init(id: th.id, theater: th, times: times))
            }
        }

        filteredShowtimes = result.sorted { $0.theater.name < $1.theater.name }
    }
}

//더미데이터 생성
private extension ReserveViewModel {
    static func createDummyScreenings(movies: [MovieModel], theaters: [TheaterModel]) -> [ScreeningModel] {
        guard let 귀멸 = movies.first(where: { $0.name.contains("귀멸") }),
              let 모노노케 = movies.first(where: { $0.name.contains("모노노케") }),
              let f1 = movies.first(where: { $0.name.contains("F1") }),
              let 극장1 = theaters.first,
              let 극장2 = theaters.dropFirst().first,
              let 극장3 = theaters.last else {
            return []
        }
        
        let calendar = Calendar.current
        let 오늘 = Date()
        
        func 시간만들기(일수: Int, 시: Int, 분: Int) -> Date {
            let 날짜 = calendar.date(byAdding: .day, value: 일수, to: 오늘)!
            return calendar.date(bySettingHour: 시, minute: 분, second: 0, of: 날짜)!
        }
        
        return [
            // 오늘
            ScreeningModel(movieId: 귀멸.id, theaterId: 극장1.id, info: "2D",
                          startAt: 시간만들기(일수: 0, 시: 10, 분: 30),
                          endAt: 시간만들기(일수: 0, 시: 12, 분: 40),
                          seatsTotal: 150, seatsAvailable: 72),
            ScreeningModel(movieId: 귀멸.id, theaterId: 극장1.id, info: "2D",
                          startAt: 시간만들기(일수: 0, 시: 15, 분: 10),
                          endAt: 시간만들기(일수: 0, 시: 17, 분: 20),
                          seatsTotal: 150, seatsAvailable: 28),
            ScreeningModel(movieId: 귀멸.id, theaterId: 극장2.id, info: "IMAX",
                          startAt: 시간만들기(일수: 0, 시: 13, 분: 0),
                          endAt: 시간만들기(일수: 0, 시: 15, 분: 10),
                          seatsTotal: 200, seatsAvailable: 150),
            ScreeningModel(movieId: 모노노케.id, theaterId: 극장1.id, info: "2D",
                          startAt: 시간만들기(일수: 0, 시: 19, 분: 0),
                          endAt: 시간만들기(일수: 0, 시: 21, 분: 30),
                          seatsTotal: 150, seatsAvailable: 130),
            // 내일
            ScreeningModel(movieId: 귀멸.id, theaterId: 극장2.id, info: "2D",
                          startAt: 시간만들기(일수: 1, 시: 11, 분: 0),
                          endAt: 시간만들기(일수: 1, 시: 13, 분: 10),
                          seatsTotal: 120, seatsAvailable: 5),
            ScreeningModel(movieId: f1.id, theaterId: 극장3.id, info: "IMAX",
                          startAt: 시간만들기(일수: 1, 시: 16, 분: 50),
                          endAt: 시간만들기(일수: 1, 시: 19, 분: 0),
                          seatsTotal: 120, seatsAvailable: 94),
        ]
    }
}
