//
//  LoginView.swift
//  MegaBox
//
//  Created by 김도연 on 9/15/25.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("userId") private var userId: String = ""
    @AppStorage("password") private var password: String = ""
    
    @State var vm = LoginViewModel()
    
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
    }
    
    private var textSection: some View {
        VStack(spacing: 40) {
            VStack {
                TextField("아이디", text: $vm.userId)
                    .font(.medium16)
                Divider()
            }
            VStack {
                SecureField("비밀번호", text: $vm.password)
                    .font(.medium16)
                Divider()
            }
        }
    }
    
    private var loginSection: some View {
        VStack(spacing: 17) {
            Button {
                userId = vm.userId
                password = vm.password
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
            
            Button {
                
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
        LoginView()
    }
}
