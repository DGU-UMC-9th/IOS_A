//
//  LoginViewModel.swift
//  MegaBox
//
//  Created by 김도연 on 9/18/25.
//

import SwiftUI
import Foundation
import Observation
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

@Observable
class LoginViewModel {
    var isAuthenticated = false
    var userId: String = ""
    var password: String = ""
    
    var showAlert: Bool = false
    var alertMessage: String = ""
    
    init() {
        checkAutoLogin()
    }
    
    // MARK: - 자동 로그인 체크
    private func checkAutoLogin() {
        let keychain = KeychainHelper.shared
        
        // 키체인에서 토큰 확인
        if keychain.loadString(forKey: KeychainHelper.Key.accessToken) != nil {
            // 토큰 유효성 검사
            // 카카오의 경우, 토큰이 있는지 확인하고 자동 로그인 시도
            if (AuthApi.hasToken()) {
                UserApi.shared.accessTokenInfo { (_, error) in
                    if let error = error {
                        if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                            print("카카오 토큰 만료, 다시 로그인 필요")
                        }
                        else {
                            print("카카오 토큰 에러: \(error)")
                        }
                        _ = keychain.delete(forKey: KeychainHelper.Key.accessToken)
                        self.isAuthenticated = false
                    }
                    else {
                        print("카카오 자동 로그인 성공")
                        self.isAuthenticated = true
                    }
                }
            } else {
                 isAuthenticated = true
                 print("일반 자동 로그인 성공")
            }
        }
    }
    
    // MARK: - 일반 로그인
    func login() {
        let keychain = KeychainHelper.shared
        let storedId = keychain.loadString(forKey: KeychainHelper.Key.userId)
        let storedPassword = keychain.loadString(forKey: KeychainHelper.Key.password)
        
        if userId == storedId && password == storedPassword {
            let token = UUID().uuidString
            _ = keychain.save(token, forKey: KeychainHelper.Key.accessToken)
            
            isAuthenticated = true
            print("로그인 됨")
        } else {
            alertMessage = "아이디 또는 비밀번호가 일치하지 않습니다."
            showAlert = true
        }
    }
    
    //MARK: - 카카오 로그인
    
    // 카카오 로그인 성공/실패 처리를 위한 공통 핸들러
    private func processKakaoLogin(token: OAuthToken?, error: Error?) {
        if let error = error {
            print(error)
            alertMessage = "카카오 로그인에 실패했습니다. \(error.localizedDescription)"
            showAlert = true
        }
        else if let token = token {
            print("login success.")
            
            let keychain = KeychainHelper.shared
            _ = keychain.save(token.accessToken, forKey: KeychainHelper.Key.accessToken)
            
            self.isAuthenticated = true
        }
    }
    
    func kakaoLonginWithApp() {
        UserApi.shared.loginWithKakaoTalk(completion: processKakaoLogin)
    }
    
    func kakaoLoginWithAccount() {
        UserApi.shared.loginWithKakaoAccount(completion: processKakaoLogin)
    }
    
    func KakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            kakaoLonginWithApp()
        } else {
            kakaoLoginWithAccount()
        }
    }
    
    // MARK: - 회원가입
    func signUp(id: String, password: String) -> Bool {
        guard !id.isEmpty, !password.isEmpty else {
            alertMessage = "아이디와 비밀번호를 모두 입력해주세요."
            showAlert = true
            return false
        }
        
        let keychain = KeychainHelper.shared
        
        // 키체인에 저장
        let idSaved = keychain.save(id, forKey: KeychainHelper.Key.userId)
        let pwSaved = keychain.save(password, forKey: KeychainHelper.Key.password)
        
        if idSaved && pwSaved {
            alertMessage = "회원가입이 완료되었습니다."
            showAlert = true
            return true
        } else {
            alertMessage = "회원가입에 실패했습니다. 다시 시도해주세요."
            showAlert = true
            return false
        }
    }
    
    // MARK: - 로그아웃
    func logout() {
        let keychain = KeychainHelper.shared
        _ = keychain.delete(forKey: KeychainHelper.Key.accessToken)
        
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("kakao logout() success.")
            }
        }
        isAuthenticated = false
        print("로그아웃 됨")
    }
    
    // MARK: - 연결 끊기
    func kakaoUnlink() {
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
                let keychain = KeychainHelper.shared
                _ = keychain.delete(forKey: KeychainHelper.Key.accessToken)
                _ = keychain.delete(forKey: KeychainHelper.Key.userId)
                _ = keychain.delete(forKey: KeychainHelper.Key.password)
                self.isAuthenticated = false
            }
        }
    }
}
