//
//  LoginViewModel.swift
//  megabox
//
//  Created by 백지은 on 9/27/25.
//

import SwiftUI
import Foundation
import Observation
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class LoginViewModel: ObservableObject {
    @Published var isLogined: Bool = false
    @Published var id: String = ""
    @Published var password: String = ""
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    init() {
        checkAutoLogin()
    }
    
    // MARK: - 일반 로그인
    func login() {
        let keychain = KeychainHelper.shared
        let storedId = keychain.loadString(forKey: KeychainHelper.Key.id)
        let storedPassword = keychain.loadString(forKey: KeychainHelper.Key.password)
        
        guard id == storedId, password == storedPassword else {
            alertMessage = "아이디 또는 비밀번호가 일치하지 않습니다."
            showAlert = true
            return
        }
        
        isLogined = true
        print("로그인 성공")
    }
    
    // MARK: - 자동 로그인
    private func checkAutoLogin() {
        let keychain = KeychainHelper.shared
        
        // 1. 일반 로그인 자동 로그인
        if keychain.loadString(forKey: KeychainHelper.Key.id) != nil,
           keychain.loadString(forKey: KeychainHelper.Key.password) != nil {
            isLogined = true
            print("일반 자동 로그인 성공")
            return
        }
        
        // 2. 카카오 로그인 자동 로그인 (토큰 존재 여부 확인)
        if keychain.loadString(forKey: KeychainHelper.Key.accessToken) != nil {
            // 카카오 토큰은 유효성 검증 필요
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    print("카카오 자동 로그인 실패: \(error.localizedDescription)")
                } else {
                    self.isLogined = true
                    print("카카오 자동 로그인 성공")
                }
            }
        }
    }
    
    // MARK: - 카카오 로그인 공통 처리
    private func processKakaoLogin(token: OAuthToken?, error: Error?) {
        if let error = error {
            print(error)
            alertMessage = "카카오 로그인에 실패했습니다. \(error.localizedDescription)"
            showAlert = true
            return
        }
        
        guard let token = token else {
            alertMessage = "카카오 로그인 토큰을 가져오지 못했습니다."
            showAlert = true
            return
        }
        
        print("카카오 로그인 성공")

        // 키체인 저장
        let keychain = KeychainHelper.shared
        _ = keychain.save(token.accessToken, forKey: KeychainHelper.Key.accessToken)
        
        isLogined = true
    }
    
    func kakaoLoginWithApp() {
        UserApi.shared.loginWithKakaoTalk(completion: processKakaoLogin)
    }
    
    func kakaoLoginWithAccount() {
        UserApi.shared.loginWithKakaoAccount(completion: processKakaoLogin)
    }
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            kakaoLoginWithApp()
        } else {
            kakaoLoginWithAccount()
        }
    }

    // MARK: - 로그아웃
    func logout() {
        let keychain = KeychainHelper.shared
        _ = keychain.delete(forKey: KeychainHelper.Key.accessToken)
        
        UserApi.shared.logout { error in
            if let error = error {
                print("카카오 로그아웃 실패: \(error.localizedDescription)")
            } else {
                print("카카오 로그아웃 성공")
            }
        }
        
        isLogined = false
        print("로그아웃 성공")
    }
}
