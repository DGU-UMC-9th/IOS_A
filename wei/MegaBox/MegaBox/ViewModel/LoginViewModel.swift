//
//  LoginViewModel.swift
//  MegaBox
//
//  Created by 이연우 on 9/29/25.
//

import Foundation
import SwiftUI

@Observable
class LoginViewModel{
    
    var id: String = ""
    var password: String = ""
    var isLoggedIn: Bool = false
    
    
    let LoginModel: [LoginModel] = [
        .init(username: "", password: "")
    ]
    
    
    func login(id: String, password: String)  {
        if (self.id == id && self.password == password) {
            isLoggedIn = true
        }
            
    }
    
}
