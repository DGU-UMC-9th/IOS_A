//
//  LoginViewModel.swift
//  Megabox
//
//  Created by 송민교 on 9/28/25.
//
 
import Foundation
import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

@Observable
class LoginViewModel{
    var loginModel = LoginModel(id: "", pw: "")
    var isLoginSuccess = false
    
    private let keychain = KeychainService.shared
    
    func login(storedID: String, storedPW: String){
        if loginModel.id == storedID && loginModel.pw == storedPW{
            
            // 키체인 저장
            keychain.savePasswordToKeychain(id: loginModel.id, password: loginModel.pw)
            
            // 상태 업데이트
            isLoginSuccess = true
            
        } else{
            isLoginSuccess = false
        }
    }
    
    func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
                   // 카카오톡 앱으로 로그인
                   UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                       if let error = error {
                           print("카카오톡 로그인 실패:", error)
                       } else {
                           self?.handlekakaoLoginSuccess(oauthToken)
                       }
                   }
               } else {
                   // 카카오 계정 웹 로그인
                   UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                       if let error = error {
                           print("카카오 계정 로그인 실패:", error)
                       } else {
                           self?.handlekakaoLoginSuccess(oauthToken)
                       }
                   }
               }
       }
    
    // 카카오 로그인 성공 처리
    private func handlekakaoLoginSuccess(_ oauthToken: OAuthToken?){
        guard let oauthToken = oauthToken else { return }
        let accessToken = oauthToken.accessToken
        print("카카오 로그인 성공, 토큰:", accessToken)
        
        isLoginSuccess = true
    }
    
    func autoLoginConfirm(){
        if let pw = keychain.loadPasswordFromKeychain(id: loginModel.id), !pw.isEmpty
        {
            print("자동 로그인 성공")
            isLoginSuccess = true
        } else {
            print("자동 로그인 실패")
        }
    }
    
    func logout(){
        keychain.delete(id: loginModel.id)
        isLoginSuccess = false
        loginModel.id = ""
        loginModel.pw = ""
    }
}
