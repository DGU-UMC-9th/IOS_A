//
//  LoginViewModel.swift
//  Megabox
//
//  Created by 송민교 on 9/28/25.
//
 
import Foundation
import SwiftUI

@Observable
class LoginViewModel{
    var loginModel = LoginModel(id: "", pw: "")
    var isLoginSuccess = false
    
    func loginConfirm(storedID: String, storedPW: String){
        if loginModel.id == storedID && loginModel.pw == storedPW{
            isLoginSuccess = true
        } else{
            isLoginSuccess = false
        }
    }
}
