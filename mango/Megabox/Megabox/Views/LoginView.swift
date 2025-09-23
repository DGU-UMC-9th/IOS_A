//
//  LoginView.swift
//  Megabox
//
//  Created by 송민교 on 9/19/25.
//

import SwiftUI

struct LoginView: View {
    @State private var id: String = ""
    @State private var pw: String = ""
    
    var body: some View {
        VStack {
            LoginHeader()
            Spacer()
            LoginInput(id: $id, pw: $pw)
            Spacer()
            LoginButton()
            Spacer()
            SocialLogin()
            PromoImage()
            Spacer()
        }
        .padding(.horizontal, 16.5)
    }
}

private struct LoginHeader: View {
    var body: some View {
        Text("로그인")
            .font(.pretend(type: .semibold, size: 24))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 20)
    }
}

private struct LoginInput: View {
    @Binding var id: String
    @Binding var pw: String
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 4) {
                TextField("아이디", text: $id)
                    .font(.pretend(type: .medium, size: 16))
                    .foregroundStyle(Color.gray03)
                Divider()
                    .frame(height: 1)
                    .background(Color.gray02)
            }
            VStack(spacing: 4) {
                TextField("비밀번호", text: $pw)
                    .font(.pretend(type: .medium, size: 16))
                    .foregroundStyle(Color.gray03)
                Divider()
                    .frame(height: 1)
                    .background(Color.gray02)
            }
        }
        .frame(height: 86)
    }
}

private struct LoginButton: View {
    var body: some View {
        VStack(spacing: 17) {
            Button(action: {}) {
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
}

private struct SocialLogin: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("naver")
            Spacer()
            Image("kakao")
            Spacer()
            Image("apple")
        }
        .frame(width: 266, height: 40, alignment: .top)
    }
}

private struct PromoImage: View {
    var body: some View {
        Image("umc")
            .resizable()
            .frame(height: 266)
    }
}

enum PREVIEW_DEVICE_TYPE : String, CaseIterable {
    case iPhone_15_Pro = "iPhone 16 Pro Max"
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

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            LoginView()
        }
    }
}
