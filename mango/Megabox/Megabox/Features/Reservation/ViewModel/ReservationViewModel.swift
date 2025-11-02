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
        .init(movieImageName: "f1", title: "F1 더 무비", isSelected: false),
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
                    self.fetchSchedules(for: movie)
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
    
    func fetchSchedules(for movie: MovieSelectModel){
        // 1. 백그라운드 스레드에서 비동기 처리
        DispatchQueue.global().async {
            // 2. JSON 파일 찾기
            guard let url = Bundle.main.url(
                forResource: "MovieSchedule", withExtension: "json")
            else {
                print("json 파일을 찾을 수 없습니다.")
                return
                }
            
            do {
                // 3. 파일에서 데이터 읽기
                let data = try Data(contentsOf: url)
                
                // 4. JSON 디코딩
                let decoded = try JSONDecoder().decode(APIResponse.self, from:data)
                let movies = decoded.data.movies
                
                // 5. 해당 영화 제목과 일치하는 항목 찾기
                if let matched = movies.first(where: {$0.title == movie.title}){
                    let theaterInfos = matched.toTheaterInfos() // DTO -> Domain 변환
                    
                    // 6. 메인스레드에서 UI
                    DispatchQueue.main.async {
                        self.allTheaterInfos = theaterInfos
                        print("상영 정보 로드 완료")
                    }
                } else {
                    DispatchQueue.main.async{
                        self.allTheaterInfos = []
                        print("관련 상영 정보가 없습니다")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                    self.allTheaterInfos = []
                }
            }
        }
    }
    
    private static func getTodayString() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.dd"
            return formatter.string(from: Date())
        }
}
