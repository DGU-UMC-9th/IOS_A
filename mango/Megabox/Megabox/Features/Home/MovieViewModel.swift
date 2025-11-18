//
//  HomeViewModel.swift
//  Megabox
//
//  Created by 송민교 on 10/5/25.
//

import SwiftUI
import Observation
import Moya
import Alamofire


extension TMDBMovieDTO{
    func toMovieModel() -> MovieModel {
        // 포스터 이미지 URL 경로 (TMDB URL + 경로)
        let fullPosterURL = "https://image.tmdb.org/t/p/w500/\(self.posterPath ?? "")"
        let ageRating = self.adult ? "청소년 관람불가" : "12세 이상 관람가"
        
        return MovieModel(
            movieTitle: self.title,
            movieCount: "50만",
            movieImageName: fullPosterURL,
            // TMDB에 없는 필드
            topPosterImageName: "TopPoster_default",
            bottomPosterImageName: "BottomPoster_default",
            
            originalTitle: self.originalTitle,
            tagline: self.overview, // tagline이 없음,,,
            synopsis: self.overview,
            rating: ageRating,
            releaseDate: "\(self.releaseDate ?? "미정") 개봉")
    }
}

@Observable
class MovieViewModel {
    let provider = MoyaProvider<TMDBRouter>()
    var currentIndex: Int = 0
    
    var movieChartList: [MovieModel] = []
    
    let comingSoonList: [MovieModel] = [
        .init(
            movieTitle: "The Roses",
            movieCount: "20만",
            movieImageName: "theroses",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "The Roses",
            tagline: "그들의 이야기가 시작된다",
            synopsis: "장미꽃처럼 아름답고 잔인한 이야기.",
            rating: "15세 이상 관람가",
            releaseDate: "2025.11.01 개봉"
        ),
        .init(
            movieTitle: "보스",
            movieCount: "1",
            movieImageName: "boss",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "The Boss",
            tagline: "진정한 보스의 탄생",
            synopsis: "조직의 보스가 되기 위한 치열한 경쟁.",
            rating: "청소년 관람불가",
            releaseDate: "2025.12.01 개봉"
        ),
        .init(
            movieTitle: "야당",
            movieCount: "20만",
            movieImageName: "movie4",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "The Opposition",
            tagline: "그들의 반란이 시작된다",
            synopsis: "거대한 권력에 맞서는 야당의 이야기.",
            rating: "12세 이상 관람가",
            releaseDate: "2025.12.25 개봉"
        )
    ]
    
    func fetchNowPlayingMovies() async{
        let language = "ko-KR"
        let page = 1
        let region = "KR"
        
        do {
            // 1. moya Provider async/await 호출
            let response = try await provider.requestAsync(.nowPlaying(language: language, page: page, region: region))
            
            // 2. 응답 데이터를 DTO로 디코딩
            let tmdbResponse = try response.map(NowPlayingResponseDTO.self)
            
            // 3. DTO의 results 배열을 toMovieModel() 함수를 사용해 최종 모델로 매핑
            let mappedMovies = tmdbResponse.results.map {$0.toMovieModel()}
            
            // 4. Mainactor에서 UI 업데이트
            await MainActor.run{
                self.movieChartList = mappedMovies
            }
        } catch {
            print("TMDB API 호출 에러: \(error.localizedDescription)")
        }
    }
}

// Moya를 async/await으로 호출할 수 있도록 하는 함수
extension MoyaProvider{
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
