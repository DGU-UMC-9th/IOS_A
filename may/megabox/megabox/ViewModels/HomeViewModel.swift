//
//  HomeViewModel.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI
import Observation
import Moya

@Observable
class HomeViewModel{
    var chartList: [MovieModel] = []
    var isLoading = false
    var errorMessage: String?
    
    var feedList: [MovieFeed] = [
        MovieFeed(title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉", description: "<모노노케 히메>,<퍼펙트 블루>", posterImage: Image(.feed1)),
        MovieFeed(title: "메가박스 오리지널 티켓 Re.37 <얼굴>", description: "영화 속 양극적인 감정의 대비", posterImage: Image(.feed2))
    ]
    
    private let provider = MoyaProvider<TMDBAPITarget>()
    
    @MainActor
    func fetchNowPlayingMovies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await provider.request(.nowPlaying())
            let decoder = JSONDecoder()
            let tmdbResponse = try decoder.decode(TMDBResponse.self, from: response.data)
            
            // DTO를 도메인 모델로 매핑
            chartList = tmdbResponse.results.map { MovieModelMapper.toDomain(from: $0) }
            
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "영화 목록을 불러오는데 실패했습니다: \(error.localizedDescription)"
            print("API 호출 에러: \(error)")
        }
    }
}
