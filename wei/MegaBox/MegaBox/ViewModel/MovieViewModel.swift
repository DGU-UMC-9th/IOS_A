//
//  HomeViewModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation
import Moya

@Observable
class MovieViewModel {
    var movies: [MovieModel] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let provider = MoyaProvider<MovieAPI>()
    
    init() {}
    
    // MARK: - Now Playing 영화 목록 가져오기
    @MainActor
    func fetchNowPlayingMovies(page: Int = 1) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await provider.async.request(.nowPlaying(page: page))
            let nowPlayingResponse = try response.map(NowPlayingResponse.self)
            
            // API 응답을 MovieModel로 변환
            self.movies = nowPlayingResponse.results.map { $0.toMovieModel() }
            
            print("✅ 영화 \(movies.count)개 로드 완료")
            
        } catch let moyaError as MoyaError {
            handleError(moyaError)
        } catch {
            errorMessage = "알 수 없는 오류가 발생했습니다."
            print("❌ Error: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    // MARK: - 에러 처리
    private func handleError(_ error: MoyaError) {
        switch error {
        case .statusCode(let response):
            errorMessage = "서버 오류: \(response.statusCode)"
            print("❌ Status Code Error: \(response.statusCode)")
            
        case .underlying(let nsError as NSError, _):
            if nsError.domain == NSURLErrorDomain {
                errorMessage = "네트워크 연결을 확인해주세요."
            } else {
                errorMessage = "요청 실패: \(nsError.localizedDescription)"
            }
            print("❌ Underlying Error: \(nsError)")
            
        default:
            errorMessage = "요청 처리 중 오류가 발생했습니다."
            print("❌ Moya Error: \(error.localizedDescription)")
        }
    }
}

// MARK: - MoyaProvider Async Extension
extension MoyaProvider {
    var async: AsyncMoyaProvider<Target> {
        AsyncMoyaProvider(provider: self)
    }
}

class AsyncMoyaProvider<Target: TargetType> {
    private let provider: MoyaProvider<Target>
    
    init(provider: MoyaProvider<Target>) {
        self.provider = provider
    }
    
    func request(_ target: Target) async throws -> Response {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
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

