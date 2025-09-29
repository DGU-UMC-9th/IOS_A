import SwiftUI
import Foundation


struct LoginView: View {
    var body: some View {
        VStack(spacing: 36) {
            loginSection
            ButtonSection
            socialLoginSection
                .padding(.top, 20)
            //Spacer()
            bannerSection
        }.padding(.bottom, 40)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("로그인")
                    .font(.semiBold24)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 80)
        .background(.white)
    }
    
    private var loginSection: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 8) {
                Text("아이디")
                    .font(.medium16)
                    .foregroundColor(.gray03)
                    //.frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                    .foregroundColor(.gray02)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("비밀번호")
                    .font(.medium16)
                    .foregroundColor(.gray03)
                    //.frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                    .foregroundColor(.gray02)
            }
        }
    }
    
    private var ButtonSection: some View {
        VStack(spacing: 17) {
            Button {
                // 로그인 액션
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.purple03)
                    .frame(height: 54)
                    .overlay(
                        Text("로그인")
                            .font(.bold18)
                            .foregroundColor(.white)
                    )
            }
            
            Button {
                // 회원가입 액션
            } label: {
                Text("회원가입")
                    .font(.medium13)
                    .foregroundColor(.gray04)
            }
        }
    }
    
    private var socialLoginSection: some View {
        HStack(spacing: 70) {
            Button {
            } label: {
                Image(.loginBtn1)
            }
            
            Button {
            } label: {
                Image(.loginBtn2)
            }
            
            Button {
            } label: {
                Image(.loginBtn3)
            }
        }
    }
    
    private var bannerSection: some View {
        Image(.umc1)
            .resizable()
            .aspectRatio(contentMode: .fill)
            //.frame(maxWidth: .infinity)
            //.frame(height: 266)
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView()
        }
    }
}

