import SwiftUI
import Foundation
import Observation


struct LoginView: View {
    
    @State var viewModel: LoginViewModel
    
    @AppStorage("id") private var id: String = ""
    @AppStorage("password") private var password: String = ""
    @AppStorage("name") private var name: String = ""
    
    @State private var idInput: String = ""
    @State private var passwordInput: String = ""
    
    
    var body: some View {
        if viewModel.isLoggedIn {
                    MainTabView()
                }
        else{
            NavigationStack{
            VStack(spacing: 36) {
                loginSection
                ButtonSection
                socialLoginSection
                    .padding(.top, 20)
                
                bannerSection
            }
            .padding(.bottom, 40)
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
//            .navigationDestination(isPresented: $isLoggedIn) {
//                        MainTabView()
//                            .navigationBarBackButtonHidden(true)
//                    }
        }}
        
       
    }
    
    private var loginSection: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 8) {
                TextField("아이디", text: $idInput)
                    .font(.medium16)
                    .foregroundColor(.gray03)
                    .autocapitalization(.none)
                    
                Divider()
                    .foregroundColor(.gray02)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                SecureField("비밀번호", text: $passwordInput)
                    .font(.medium16)
                    .foregroundColor(.gray03)
                    
                Divider()
                    .foregroundColor(.gray02)
            }
        }
    }
    
    private var ButtonSection: some View {
        VStack(spacing: 17) {
            Button {
                viewModel.login(id: idInput, password: passwordInput)
                
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
    }
}




enum PREVIEW_DEVICE_TYPE : String, CaseIterable {
    case iPhone_16_Pro = "iPhone 16 Pro"
    case iPhone_11 = "iPhone 11"
    
    var previewDevice: PreviewDevice {
        .init(rawValue: self.rawValue)
    }
}

func devicePreviews<Content: View>(
    content: @escaping () -> Content
) -> some View {
    ForEach(PREVIEW_DEVICE_TYPE.allCases, id: \.self) { device in
        content()
            .previewDevice(device.previewDevice)
            .previewDisplayName(device.rawValue)
    }
}


#Preview {
    LoginView(viewModel: LoginViewModel())
}
