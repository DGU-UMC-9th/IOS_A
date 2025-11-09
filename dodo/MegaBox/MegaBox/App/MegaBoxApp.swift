//
//  MegaBoxApp.swift
//  MegaBox
//
//  Created by 김도연 on 9/15/25.
//

import SwiftUI
import KakaoSDKAuth

@main
struct MegaBoxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    // 카카오 로그인 URL 처리
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
