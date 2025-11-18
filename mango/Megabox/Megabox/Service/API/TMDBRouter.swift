//
//  APITargetType.swift
//  Megabox
//
//  Created by 송민교 on 11/17/25.
//

import Foundation
import Moya
import Alamofire



enum TMDBRouter {
    case nowPlaying(language: String, page: Int, region: String)
}

extension TMDBRouter: TargetType {
    // 1. baseURL
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org")!
    }
    
    // 2. path
    var path: String{
        switch self{
        case .nowPlaying:
            return "/3/movie/now_playing"
        }
    }
    
    // 3. method: HTTP 방식
    var method: Moya.Method {
        return .get
    }
    
    // 4. task: 쿼리 파라미터
    var task: Task {
        switch self{
        case .nowPlaying(let language, let page, let region):
            let parameters: [String: Any] = [
                "api_key": AppConfig.APIKey,
                "language": language,
                "page": page,
                "region": region
            ]
            
            // Query Parameters를 URL 쿼리 문자열 형태로 인코딩해서 요청
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    // 5. headers
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    // 6. sampleData - 테스트용 가짜 데이터
    var sampleData: Data{
        return Data()
    }
}
