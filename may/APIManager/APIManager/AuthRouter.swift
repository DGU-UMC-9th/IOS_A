//
//  AuthRouter.swift
//  APIManager
//
//  Created by 백지은 on 11/16/25.
//

import Foundation
import Moya
import Alamofire

enum AuthRouter {
    case login(request: LoginRequest)
    case refreshToken(request: RefreshTokenRequest)
    case logout(request: RefreshTokenRequest)
}

extension AuthRouter: APITargetType {
    var path: String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .refreshToken:
            return "/api/auth/refresh"
        case .logout:
            return "/api/auth/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .refreshToken, .logout:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let request):
            return .requestJSONEncodable(request)
        case .refreshToken(let request):
            return .requestJSONEncodable(request)
        case .logout(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
