//
//  LoginView.swift
//  MegaBox
//
//  Created by 김도연 on 9/15/25.
//

import SwiftUI

struct LoginView: View {
    @State var vm: LoginViewModel
    
    var body: some View {
        VStack(spacing: 36) {
            textSection
            loginSection
            socialLoginSection
            bannerSection
        }
        .toolbar {
            ToolbarItem(placement: .principal){
                Text("로그인")
                    .font(.semiBold24)
            }
        }
        .padding(.horizontal, 16)
        .alert("로그인 실패", isPresented: $vm.showAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(vm.alertMessage)
        }
    }
    
    
    private var textSection: some View {
        VStack(spacing: 40) {
            VStack {
                TextField("아이디", text: $vm.userId)
                    .textInputAutocapitalization(.never)
                    .font(.medium16)
                Divider()
            }
            VStack {
                SecureField("비밀번호", text: $vm.password)
                    .textInputAutocapitalization(.never)
                    .font(.medium16)
                Divider()
            }
        }
    }
    
    private var loginSection: some View {
        VStack(spacing: 17) {
            Button {
                vm.login()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.purple03)
                    .frame(height: 52)
                    .overlay(
                        Text("로그인")
                            .font(.bold18)
                            .foregroundColor(.white)
                    )
            }
            
            NavigationLink {
                SignUpView()
            } label: {
                Text("회원가입")
                    .font(.medium13)
                    .foregroundStyle(.gray04)
            }
        }
    }
    
    private var socialLoginSection: some View {
        HStack(spacing: 52) {
            Button {
                
            } label: {
                Image(.naver)
            }
            
            Button {
                
            } label: {
                Image(.kakao)
            }
            
            Button {
                
            } label: {
                Image(.apple)
            }
        }
    }
    
    private var bannerSection: some View {
        Image(.UMC)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        LoginView(vm: LoginViewModel())
    }
}
