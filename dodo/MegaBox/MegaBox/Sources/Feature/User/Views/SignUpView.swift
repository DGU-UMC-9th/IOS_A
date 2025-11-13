//
//  SignUpView.swift
//  MegaBox
//
//  Created by 김도연 on 10/1/25.
//  LoginViewModel 공유 사용
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var vm: LoginViewModel
    
    @State private var id: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            TextField("아이디", text: $id)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            Divider()
            
            SecureField("비밀번호", text: $password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            Divider()
            
            Button {
                if vm.signUp(id: id, password: password) {
                    dismiss()
                }
            } label: {
                Text("회원가입")
            }
        }
        .padding(.horizontal)
        .navigationTitle("회원가입")
        .alert("알림", isPresented: $vm.showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(vm.alertMessage)
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView(vm: LoginViewModel())
    }
}
