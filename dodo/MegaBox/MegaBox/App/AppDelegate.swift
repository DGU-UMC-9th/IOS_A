//
//  AppDelegate.swift
//  MegaBox
//
//  Created by 김도연 on 11/10/25.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        KakaoSDK.initSDK(appKey: Config.KAKAO_APP_KEY)
        
        return true
    }
}
