//
//  TargetType.swift
//  megabox
//
//  Created by 백지은 on 11/16/25.
//

import Moya
import Foundation

enum TMDBAPITarget {
    case nowPlaying(language: String = "ko-KR", page: Int = 1, region: String = "KR")
}

extension TMDBAPITarget: TargetType {
    var baseURL: URL { 
        URL(string: Config.getBaseURL())!
    }
    
    var path: String {
        switch self {
        case .nowPlaying: return "/movie/now_playing"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        switch self {
        case .nowPlaying(let language, let page, let region):
            return .requestParameters(
                parameters: [
                    "api_key": Config.getAPIKey(),
                    "language": language,
                    "page": page,
                    "region": region
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var sampleData: Data { Data() }
}

// MARK: - MoyaProvider async/await Extension
extension MoyaProvider {
    func request(_ target: Target) async throws -> Response {
        return try await withCheckedThrowingContinuation { continuation in
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
