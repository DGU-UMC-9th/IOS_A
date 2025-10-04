//
//  LoginViewModel.swift
//  megabox
//
//  Created by 백지은 on 9/27/25.
//

import SwiftUI
import Foundation
import Observation

@Observable
class LoginViewModel {
    var isLogined: Bool = false
    var id: String = ""
    var password: String = ""
    
    var showAlert: Bool = false
    var alertMessage: String = ""
    
    init() {
        // 테스트용
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "id") == nil {
            defaults.set("user", forKey: "id")
        }
        if defaults.string(forKey: "password") == nil {
            defaults.set("ps", forKey: "password")
        }
    }
    
    func login() {
        let storedId = UserDefaults.standard.string(forKey: "id")
        let storedPassword = UserDefaults.standard.string(forKey: "password")
        
        guard let storedId, let storedPassword else {
            print("저장된 값이 없습니다.")
            return
        }
        
        if id == storedId && password == storedPassword {
            isLogined = true
            print("로그인 성공")
        } else {
            alertMessage = "아이디 또는 비밀번호가 일치하지 않습니다."
            showAlert = true
            print("로그인 실패")
        }
    }
}
