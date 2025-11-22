//
//  File.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//
import Foundation
import SwiftUI

struct RootView: View {
    
    @State private var loginViewModel = LoginViewModel()

    var body: some View {
        Group {
            if loginViewModel.isLoggedIn {
                // 로그인 후: 메인 플로우
                MainTabView(viewModel: loginViewModel)
                    // 각 탭 내부에서 NavigationStack을 가집니다.
            } else {
                // 로그인 전: 로그인 플로우
                LoginView(viewModel: loginViewModel)
            }
        }
    }
}

#Preview {
    RootView()
}
