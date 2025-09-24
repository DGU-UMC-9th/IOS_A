//
//  LoginView.swift
//  MegaBox
//
//  Created by 김도연 on 9/15/25.
//

import SwiftUI

struct LoginView: View {
    @State var id: String = ""
    @State var password: String = ""
    
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
    
    var textSection: some View {
        VStack(spacing: 40) {
            VStack {
                TextField("아이디", text: $id)
                    .font(.medium16)
                Divider()
            }
            VStack {
                SecureField("비밀번호", text: $password)
                    .font(.medium16)
                Divider()
            }
        }
    }
    
    var loginSection: some View {
        VStack(spacing: 17) {
            Button {
                
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
    
    var socialLoginSection: some View {
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
    
    var bannerSection: some View {
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
