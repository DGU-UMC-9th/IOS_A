//
//  megaboxApp.swift
//  megabox
//
//  Created by 백지은 on 9/27/25.
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
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
