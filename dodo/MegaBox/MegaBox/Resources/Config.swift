//
//  Config.swift
//  MegaBox
//
//  Created by 김도연 on 11/15/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist cannot be found")
        }
        return dict
    }()
    
    static let TMDB_BASE_URL: String = {
        guard let TMDB_BASE_URL = infoDictionary["TMDB_BASE_URL"] as? String else {
            fatalError("TMDB_BASE_URL cannot be found in info.plist")
        }
        return TMDB_BASE_URL
    }()
    
    static let TMDB_TOKEN: String = {
        guard let TMDB_TOKEN = infoDictionary["TMDB_TOKEN"] as? String else {
            fatalError("TMDB_TOKEN cannot be found in info.plist")
        }
        return TMDB_TOKEN
    }()
    
    static let TMDB_API_KEY: String = {
        guard let TMDB_API_KEY = infoDictionary["TMDB_API_KEY"] as? String else {
            fatalError("TMDB_KEY cannot be found in info.plist")
        }
        return TMDB_API_KEY
    }()
    
    static let KAKAO_APP_KEY: String = {
        guard let KAKAO_APP_KEY = infoDictionary["KAKAO_APP_KEY"] as? String else {
            fatalError("KAKAO_APP_KEY cannot be found in info.plist")
        }
        return KAKAO_APP_KEY
    }()
}
