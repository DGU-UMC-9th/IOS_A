//
//  MovieAPI.swift
//  MegaBox
//
//  Created by 이연우 on 11/23/25.
//

import Foundation
import Moya

enum MovieAPI {
    case nowPlaying(page: Int)
    case movieDetail(movieId: Int)
}

extension MovieAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .movieDetail(let movieId):
            return "/movie/\(movieId)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .nowPlaying(let page):
            return .requestParameters(
                parameters: [
                    "language": "ko-KR",
                    "page": page
                ],
                encoding: URLEncoding.queryString
            )
        case .movieDetail:
            return .requestParameters(
                parameters: [
                    "language": "ko-KR"
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String: String]? {
        return [
            "accept": "application/json",
            "Authorization": "Bearer \(Bundle.main.tmdbAccessToken)"
        ]
    }
}

extension Bundle {
    var tmdbAccessToken: String {
        guard let key = infoDictionary?["TMDB_ACCESS_TOKEN"] as? String else {
            fatalError("TMDB_ACCESS_TOKEN not found in Info.plist")
        }
        return key
    }
}
