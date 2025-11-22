//
//  Config.swift
//  megabox
//
//  Created by 백지은 on 11/16/25.
//

import Foundation

struct Config {
    /// xcconfig 파일에서 API Key를 불러옵니다.
    static func getAPIKey() -> String {
        if let apiKey = Bundle.main.infoDictionary?["MOVIE_API_KEY"] as? String {
            return apiKey
        }
        
        guard let path = Bundle.main.path(forResource: "Secret", ofType: "xcconfig"),
              let contents = try? String(contentsOfFile: path, encoding: .utf8),
              let apiKeyLine = contents.components(separatedBy: .newlines).first(where: { $0.contains("MOVIE_API_KEY") }),
              let apiKey = apiKeyLine.components(separatedBy: "=").last?.trimmingCharacters(in: .whitespaces) else {
            return ""
        }
        return apiKey
    }
    
    /// xcconfig 파일에서 Base URL을 불러옵니다.
    static func getBaseURL() -> String {
        if let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String {
            return baseURL
        }
        
        guard let path = Bundle.main.path(forResource: "Secret", ofType: "xcconfig"),
              let contents = try? String(contentsOfFile: path, encoding: .utf8),
              let baseURLLine = contents.components(separatedBy: .newlines).first(where: { $0.contains("BASE_URL") }),
              let baseURL = baseURLLine.components(separatedBy: "=").last?.trimmingCharacters(in: .whitespaces) else {
            return "https://api.themoviedb.org/3"
        }
        return baseURL
    }
}

