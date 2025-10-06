//
//  LoginView.swift
//  Megabox
//
//  Created by 송민교 on 9/19/25.
//

import SwiftUI
import Observation // @Observable, @Bindable 사용하기 위해

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @AppStorage("id") var id: String = ""
    @AppStorage("pw") var pw: String = ""
    @AppStorage("userName") var userName = ""
    
    var body: some View {
        VStack {
            LoginHeader
            Spacer()
            LoginInput(viewModel: viewModel)
            Spacer()
            LoginButton(viewModel: viewModel)
            Spacer()
            SocialLogin
            PromoImage
            Spacer()
        }
        .padding(.horizontal, 16.5)
        // navigation은 RootView에서 모두 관리하기 위해 navigationStack대신 사용
        .fullScreenCover(isPresented: $viewModel.isLoginSuccess){
            RootView()
        }
    }
    
    private var LoginHeader: some View {
        Text("로그인")
            .font(.pretend(type: .semibold, size: 24))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 20)
    }
    
    private func LoginInput(@Bindable viewModel: LoginViewModel)-> some View {
        return VStack(spacing: 40) {
            VStack(spacing: 4) {
                TextField("아이디", text: $viewModel.loginModel.id)
                    .font(.pretend(type: .medium, size: 16))
                // 첫문자 자동 대문자 끄기
                    .textInputAutocapitalization(.never)
                    .foregroundStyle(Color.gray03)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray02)
            }
            VStack(spacing: 4) {
                SecureField("비밀번호", text: $viewModel.loginModel.pw)
                    .font(.pretend(type: .medium, size: 16))
                    .foregroundStyle(Color.gray03)
                Divider()
                    .frame(height: 1)
                    .background(Color.gray02)
            }
        }
        .frame(height: 86)
    }
    
    private func LoginButton(@Bindable viewModel: LoginViewModel)-> some View {
        
        return VStack(spacing: 17) {
            Button(action: {
                id = viewModel.loginModel.id
                pw = viewModel.loginModel.pw
                userName = "송민교"
                
                viewModel.loginConfirm(storedID: id, storedPW: pw)
            }) {
                Text("로그인")
                    .font(.pretend(type: .bold, size: 18))
                    .frame(maxWidth: .infinity, minHeight: 54, alignment: .center)
                    .foregroundStyle(Color.white)
                    .background(Color.purple03)
                    .cornerRadius(12)
            }
            Text("회원가입")
                .font(.pretend(type: .medium, size: 13))
                .foregroundStyle(Color.gray03)
        }
        .frame(height: 40)
    }
    
    private var SocialLogin: some View {
        HStack(alignment: .top) {
            Image("naver")
            Spacer()
            Image("kakao")
            Spacer()
            Image("apple")
        }
        .frame(width: 266, height: 40, alignment: .top)
    }

    private var PromoImage: some View {
            Image("umc")
                .resizable()
                .frame(height: 266)
    }
}

#Preview{
    LoginView()
}

