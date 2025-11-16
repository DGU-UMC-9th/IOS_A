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
    var baseURL: URL { URL(string: "https://api.themoviedb.org/3")! }
    
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
                    "api_key": getAPIKey(),
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
    
    private func getAPIKey() -> String {
        if let apiKey = Bundle.main.infoDictionary?["MOVIE_API_KEY"] as? String {
            return apiKey
        }
        
        // Fallback: xcconfig 파일에서 직접 읽기
        guard let path = Bundle.main.path(forResource: "Secret", ofType: "xcconfig"),
              let contents = try? String(contentsOfFile: path),
              let apiKeyLine = contents.components(separatedBy: .newlines).first(where: { $0.contains("MOVIE_API_KEY") }),
              let apiKey = apiKeyLine.components(separatedBy: "=").last?.trimmingCharacters(in: .whitespaces) else {
            return ""
        }
        return apiKey
    }
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
