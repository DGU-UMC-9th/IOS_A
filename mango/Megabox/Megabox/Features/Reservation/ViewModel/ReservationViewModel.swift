//
//  ReservationViewModel.swift
//  Megabox
//
//  Created by 송민교 on 10/13/25.
//

import SwiftUI
import Combine

class MovieSelectViewModel: ObservableObject {
    public var movies:[MovieSelectModel] = [
        .init(movieImageName: "f1", title: "F1", isSelected: false),
        .init(movieImageName: "movie3", title: "주술회전", isSelected: false),
        .init(movieImageName: "movie5", title: "어쩔수가없다", isSelected: false),
        .init(movieImageName: "face", title: "얼굴", isSelected: false),
        .init(movieImageName: "mononoke", title: "모노노케 히메", isSelected: false),
        .init(movieImageName: "boss", title: "보스", isSelected: false)
    ]
    
    @Published var selectedMovie: MovieSelectModel? = nil
    var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var results: [MovieSelectModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = nil
    
    init(){
        $selectedMovie
            // 값이 바뀔때마다 sink 클로저 실행
            .sink{ [weak self] selected in
                guard let self = self else { return }
                // 기존 영화 리스트를 돌면서 새로 선택된 영화(selected)와 id가 같으면 isSelected = true
                self.movies = self.movies.map { movie in
                    var updated = movie
                    updated.isSelected = (movie.id == selected?.id)
                    return updated
                }
            }
            .store(in: &cancellables)
    }
    
    func selectMovie(_ movie: MovieSelectModel){
        if selectedMovie?.id == movie.id {
            selectedMovie = nil
        } else{
            selectedMovie = movie
        }
    }
}

class TheaterInfoViewModel: ObservableObject{
    @Published var allTheaterInfos: [TheaterInfo] = []
    @Published var selectedTheaters: [TheaterType] = []
    @Published var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    
    private var cancellables = Set<AnyCancellable>()
    
    init(movieVM: MovieSelectViewModel){
        movieVM.$selectedMovie
            .sink { [weak self] selectedMovie in
                guard let self = self else {return}
                if let movie = selectedMovie {
                    self.loadDummyData(for: movie)
                }else{
                    self.allTheaterInfos = []
                }
            }
            .store(in: &cancellables)
    }
    
    func toggleTheater(theater: TheaterType){
        if let index = selectedTheaters.firstIndex(of: theater){
            selectedTheaters.remove(at: index)
        } else {
            selectedTheaters.append(theater)
        }
    }
    
    private static func getTodayString() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.dd"
            return formatter.string(from: Date())
        }
    
    private func loadDummyData(for movie: MovieSelectModel){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM.dd"
    
        let today = formatter.string(from: Date())
        
        switch movie.title{
        case "F1" :
            allTheaterInfos = [
                TheaterInfo(theater: .gangnam,
                            movie: movie,
                            theaterDetail: "크리클라이너 1관",
                            movieTime: [
                                MovieTime(startTime: "11:30", endTime: "13:58", leftSeats: 109 , totalSeats: 116),
                                MovieTime(startTime: "14:20", endTime: "16:48", leftSeats: 19, totalSeats: 116),
                                MovieTime(startTime: "17:05", endTime: "19:28", leftSeats: 1, totalSeats: 116),
                                MovieTime(startTime: "19:45", endTime: "22:02", leftSeats: 100, totalSeats: 116),
                                MovieTime(startTime: "22:20", endTime: "00:04", leftSeats: 116, totalSeats: 116)
                            ],
                            movieDate: today),
                TheaterInfo(theater: .hongdae,
                            movie: movie,
                            theaterDetail: "BTS관(7층 1관 [Laser])",
                            movieTime: [
                                MovieTime(startTime: "9:30", endTime: "11:50", leftSeats: 75, totalSeats: 116),
                                MovieTime(startTime: "12:00", endTime: "14:26", leftSeats: 102, totalSeats: 116),
                                MovieTime(startTime: "14:45", endTime: "17:04", leftSeats: 88, totalSeats: 116)
                            ],
                            movieDate: today),
                TheaterInfo(theater: .hongdae,
                            movie: movie,
                            theaterDetail: "BTS관(9층 2관 [Laser])",
                            movieTime: [
                                MovieTime(startTime: "11:30", endTime: "13:58", leftSeats: 34, totalSeats: 116),
                                MovieTime(startTime: "14:10", endTime: "16:32", leftSeats: 100, totalSeats: 116),
                                MovieTime(startTime: "16:50", endTime: "19:00", leftSeats: 13, totalSeats: 116),
                                MovieTime(startTime: "19:20", endTime: "21:40", leftSeats: 92, totalSeats: 116)
                            ],
                            movieDate: today)
            ]
        default:
            allTheaterInfos = []
        }
    }
}
