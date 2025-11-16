//
//  AppDelegate.swift
//  megabox
//
//  Created by 백지은 on 11/10/25.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        if let kakaoKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String {
            KakaoSDK.initSDK(appKey: kakaoKey)
        } else {
            fatalError("KAKAO_APP_KEY가 Info.plist에 없습니다.")
        }
        
        return true
    }
    
    // 카카오 로그인 URL 처리
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
}
