//
//  HomeViewModel.swift
//  MegaBox
//
//  Created by 김도연 on 9/29/25.
//

import SwiftUI
import Observation
import Moya

@Observable
class HomeViewModel {
    private let movieProvider = MoyaProvider<TMDBAPITarget>()
    
    var isLoading = false
    var errorMessage: String?
    
    //영화 리스트
    var posterList: [MovieModel] = []
    //영화 상세 리스트
    var detailList: [MovieDetail] = []
    
    //무비피드 리스트 (수정x)
    var feedList: [MovieFeed] = [
        MovieFeed(title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉", description: "<모노노케 히메>,<퍼펙트 블루>", posterImage: Image(.movieFeed1)),
        MovieFeed(title: "메가박스 오리지널 티켓 Re.37 <얼굴>", description: "영화 속 양극적인 감정의 대비", posterImage: Image(.movieFeed2))
    ]
    
    init() {
        
    }
    
    func fetchMovies() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }

        do {
            let response = try await requestMovies()
            let decoded = try JSONDecoder().decode(TMDBResponse.self, from: response.data)
            
            let movies = decoded.results.map { MovieModelMapper.toDomain(from: $0) }
            let details = decoded.results.map { MovieDetailMapper.toDomain(from: $0) }
            
            await MainActor.run {
                self.posterList = movies
                self.detailList = details
                print("Movies loaded: \(movies.count)")
                print("Details loaded: \(details.count)")
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print("Error: \(error)")
                self.isLoading = false
            }
        }
    }
    
    // ID로 MovieDetail 찾기
    func getMovieDetail(by id: Int) -> MovieDetail? {
        return detailList.first(where: { $0.id == id })
    }

    private func requestMovies() async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            movieProvider.request(.getMovies) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let moyaError):
                    continuation.resume(throwing: moyaError)
                }
            }
        }
    }
}
