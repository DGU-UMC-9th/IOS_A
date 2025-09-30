//
//  LoginViewModel.swift
//  MegaBox
//
//  Created by 김도연 on 9/18/25.
//

import SwiftUI
import Foundation
import Observation

@Observable
class LoginViewModel {
    var isAuthenticated = false
    var userId: String = ""
    var password: String = ""
    
    var showAlert: Bool = false
    var alertMessage: String = ""

    func login() {
        let storedId = UserDefaults.standard.string(forKey: "userId")
        let storedPassword = UserDefaults.standard.string(forKey: "password")
        
        if userId == storedId && password == storedPassword {
            isAuthenticated = true
            print("로그인 됨")
        } else {
            alertMessage = "아이디 또는 비밀번호가 일치하지 않습니다."
            showAlert = true
        }
    }
}
