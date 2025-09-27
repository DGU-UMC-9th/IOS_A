//
//  LoginViewModel.swift
//  megabox
//
//  Created by 백지은 on 9/27/25.
//

import Foundation
import Observation

@Observable
class LoginViewModel {
    var loginModel = LoginModel(id: "", password: "")
        
    // 뷰에서 바인딩할 computed property
    var id: String {
        get { loginModel.id }
        set { loginModel.id = newValue }
    }
    
    var password: String {
        get { loginModel.password }
        set { loginModel.password = newValue }
    }
    
    // 로그인 처리 예시
    func login() {
        print("로그인 시도: \(loginModel.id), \(loginModel.password)")
        // 여기에 실제 로그인 로직 추가
    }
}
