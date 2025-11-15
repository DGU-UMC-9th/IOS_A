//
//  TMDBTargetType.swift
//  MegaBox
//
//  Created by 김도연 on 11/15/25.
//

import SwiftUI
import Moya

protocol TMDBTargetType: TargetType {}

extension TMDBTargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.TMDB_BASE_URL) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    var headers: [String : String]? {
        var headers = ["Content-Type" : "application/json"]

        headers["Authorization"] = "Bearer \(Config.TMDB_TOKEN)"
        
        return headers
    }
        
    var validationType: ValidationType { .successCodes }
}
