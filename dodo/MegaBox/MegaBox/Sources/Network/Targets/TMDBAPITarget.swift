//
//  TMDBAPITarget.swift
//  MegaBox
//
//  Created by 김도연 on 11/15/25.
//

import Foundation
import Moya

enum TMDBAPITarget {
    case getMovies
}

extension TMDBAPITarget: TMDBTargetType {
    var path: String {
        switch self {
        case .getMovies:
            return "/movie/now_playing"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovies:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMovies:
            return .requestParameters(parameters: ["language": "ko-KR", "region": "KR"], encoding: URLEncoding.default)
        }
    }
}
