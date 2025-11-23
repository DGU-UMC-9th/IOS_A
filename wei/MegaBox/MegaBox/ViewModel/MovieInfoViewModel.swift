//
//  MovieInfoViewModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation
import Moya

@Observable
class MovieInfoViewModel {
    var movieInfo: MovieInfo?
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let provider = MoyaProvider<MovieAPI>()
    
    // MARK: - 영화 상세 정보 가져오기
    @MainActor
    func fetchMovieDetail(movieId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await provider.async.request(.movieDetail(movieId: movieId))
            let detailResponse = try response.map(MovieDetailResponse.self)
            
            // API 응답을 MovieInfo로 변환
            self.movieInfo = detailResponse.toMovieInfo()
            
            print("영화 상세 정보 로드 완료: \(detailResponse.title)")
            
        } catch let moyaError as MoyaError {
            handleError(moyaError)
        } catch {
            errorMessage = "알 수 없는 오류가 발생했습니다."
            print("Error: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    // MARK: - 에러 처리
    private func handleError(_ error: MoyaError) {
        switch error {
        case .statusCode(let response):
            errorMessage = "서버 오류: \(response.statusCode)"
            print("Status Code Error: \(response.statusCode)")
            
        case .underlying(let nsError as NSError, _):
            if nsError.domain == NSURLErrorDomain {
                errorMessage = "네트워크 연결을 확인해주세요."
            } else {
                errorMessage = "요청 실패: \(nsError.localizedDescription)"
            }
            print("Underlying Error: \(nsError)")
            
        default:
            errorMessage = "요청 처리 중 오류가 발생했습니다."
            print("Moya Error: \(error.localizedDescription)")
        }
    }
}
