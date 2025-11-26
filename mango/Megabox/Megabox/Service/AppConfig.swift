//
//  AppConfig.swift
//  Megabox
//
//  Created by 송민교 on 11/11/25.
//

import Foundation

struct AppConfig {
    static var restAPIKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "REST_API_KEY") as? String else {
            fatalError("REST_API_KEY를 Info.plist에서 불러올 수 없습니다.")
        }
        return key
    }

    static var redirectURI: String {
        guard let uri = Bundle.main.object(forInfoDictionaryKey: "REDIRECT_URI") as? String else {
            fatalError("REDIRECT_URI를 Info.plist에서 불러올 수 없습니다.")
        }
        return uri
    }
    
    static var nativeAppKey: String{
        guard let key = Bundle.main.object(forInfoDictionaryKey: "NATIVE_APP_KEY") as? String else {
            fatalError("REDIRECT_URI를 Info.plist에서 불러올 수 없습니다.")
        }
        return key
    }
    
    static let APIKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY is not in Info.plist")
        }
        return key
    }()
}
