//
//  LoginView.swift
//  megabox
//
//  Created by 백지은 on 9/20/25.
//

import SwiftUI

struct LoginView: View {
    
    @State var model = LoginViewModel()
    
    var body: some View {
        VStack{
            headerSection
            Spacer()
            inputSection
            Spacer()
                .frame(height: 35)
            loginSection
            Spacer()
                .frame(height: 35)
            signupSection
            Spacer()
                .frame(height: 23)
            imgSection
            Spacer()
                .frame(height: 50)
        }
        .ignoresSafeArea(.keyboard)
        .alert("로그인 실패", isPresented: $model.showAlert) {
                    Button("확인", role: .cancel) { }
                } message: {
                    Text(model.alertMessage)
                }
        
    }
    
    //헤더
    private var headerSection: some View {
        Text("로그인")
            .font(.semiBold24)
            .padding(.top, 25)
    }
    
    //입력 필드
    private var inputSection: some View {
        
        VStack(alignment: .leading){
            TextField("아이디", text: $model.id)
                .font(.medium16)
                .textInputAutocapitalization(.never)
                .foregroundColor(.gray03)
            Divider()
            
            Spacer()
                .frame(height:40)
            
            SecureField("비밀번호", text: $model.password)
                .font(.medium16)
                .textInputAutocapitalization(.never)
                .foregroundColor(.gray03)
            Divider()
        }
        .padding(.horizontal, 16)
        
        
    }
    
    //로그인
    private var loginSection: some View {
        
        VStack(alignment: .center, spacing: 17){
            Button{
                print("클릭됨")
                model.login()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.purple03)
                    Text("로그인")
                        .font(.bold18)
                        .foregroundStyle(.white)
                }
            }
            .frame(height:54)
            
            VStack(alignment: .center){
                Text("회원가입")
                    .font(.medium13)
                    .foregroundColor(.gray04)
            }
            
        }
        .padding(.horizontal, 25)
    }
    
    //소셜 회원가입
    private var signupSection: some View {
        
        HStack(alignment: .center){
            Button (action: {
                print("네이버 로그인")
            }, label: {
                Image(.naver)
            })
            
            Spacer()
            
            Button (action: {
                print("카카오 로그인")
            }, label: {
                Image(.kakao)
            })
            
            Spacer()
            
            Button (action: {
                print("애플 로그인")
            }, label: {
                Image(.apple)
            })
            
        }
        .frame(width:266, height:40)
    }
    
    //이미지
    private var imgSection: some View {
        Image(.umc)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(16)
    }
}

#Preview {
    NavigationStack {
        LoginView(model: LoginViewModel())
    }
}
