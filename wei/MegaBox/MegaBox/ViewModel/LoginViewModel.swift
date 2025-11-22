//
//  LoginViewModel.swift
//  MegaBox
//
//  Created by 이연우 on 9/29/25.
//

import Foundation
import SwiftUI

@Observable
class LoginViewModel {
    
    var id: String = ""
    var password: String = ""
    var name: String = ""
    var isLoggedIn: Bool = false
    var loginType: LoginType = .none
    var errorMessage: String?
    
    enum LoginType {
        case none
        case normal
        case kakao
    }
    
    //더미데이터
    let validUsers: [(id: String, password: String, name: String)] = [
        ("test", "1234", "테스트유저"),
        ("admin", "admin", "관리자")
    ]
    
    init() {
        checkAutoLogin()
    }
    
    // MARK: - 자동 로그인 확인
    func checkAutoLogin() {
        // 일반 로그인 확인
        if let credentials = KeychainManager.shared.loadCredentials() {
            self.id = credentials.id
            self.password = credentials.password
            self.name = credentials.name
            self.isLoggedIn = true
            self.loginType = .normal
            print(" 자동 로그인 성공 (일반): \(credentials.name)")
            return
        }
        
        // 카카오 로그인 확인
        if let token = KeychainManager.shared.loadKakaoToken() {
            // 토큰 유효성 검증 (실제로는 서버에 확인 필요)
            validateKakaoToken(token.accessToken)
        }
    }
    
    // MARK: - 일반 로그인
    func login(id: String, password: String) {
        errorMessage = nil
        
        // 사용자 검증
        guard let user = validUsers.first(where: { $0.id == id && $0.password == password }) else {
            errorMessage = "아이디 또는 비밀번호가 올바르지 않습니다."
            return
        }
        
        do {
            // 키체인에 저장
            try KeychainManager.shared.saveCredentials(
                id: id,
                password: password,
                name: user.name
            )
            
            // 로그인 상태 업데이트
            self.id = id
            self.password = password
            self.name = user.name
            self.isLoggedIn = true
            self.loginType = .normal
            
            print("✅ 로그인 성공: \(user.name)")
            
        } catch {
            errorMessage = "로그인 정보 저장에 실패했습니다."
            print("❌ Keychain save error: \(error)")
        }
    }
    
    // MARK: - 카카오 로그인 (토큰 저장)
    func loginWithKakao(accessToken: String, refreshToken: String?, userInfo: KakaoUserInfo) {
        do {
            // 키체인에 토큰 저장
            try KeychainManager.shared.saveKakaoToken(
                accessToken: accessToken,
                refreshToken: refreshToken
            )
            
            // 로그인 상태 업데이트
            self.id = String(userInfo.id)
            self.name = userInfo.nickname ?? "카카오 사용자"
            self.isLoggedIn = true
            self.loginType = .kakao
            
            print("✅ 카카오 로그인 성공: \(self.name)")
            
        } catch {
            errorMessage = "카카오 로그인 정보 저장에 실패했습니다."
            print("❌ Keychain save error: \(error)")
        }
    }
    
    // MARK: - 카카오 토큰 검증
    private func validateKakaoToken(_ accessToken: String) {
        // 실제로는 서버에 토큰 유효성 확인 요청
        // 여기서는 단순히 토큰이 있으면 로그인된 것으로 처리
        self.isLoggedIn = true
        self.loginType = .kakao
        self.name = "카카오 사용자" // 실제로는 사용자 정보 API 호출
        print("✅ 자동 로그인 성공 (카카오)")
    }
    
    // MARK: - 로그아웃
    func logout() {
        do {
            switch loginType {
            case .normal:
                try KeychainManager.shared.deleteCredentials()
            case .kakao:
                try KeychainManager.shared.deleteKakaoToken()
            case .none:
                break
            }
            
            self.id = ""
            self.password = ""
            self.name = ""
            self.isLoggedIn = false
            self.loginType = .none
            self.errorMessage = nil
            
            print("✅ 로그아웃 성공")
            
        } catch {
            print("❌ 로그아웃 에러: \(error)")
        }
    }
}

// MARK: - 카카오 사용자 정보 모델
struct KakaoUserInfo {
    let id: Int64
    let nickname: String?
    let profileImage: String?
    let email: String?
}
