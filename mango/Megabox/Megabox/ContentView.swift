//
//  ContentView.swift
//  Megabox
//
//  Created by 송민교 on 9/19/25.
//

import SwiftUI

struct ContentView: View {
    @State private var loginViewModel = LoginViewModel()
    @Environment(NavigationRouterViewModel.self) private var router

    var body: some View {
        if loginViewModel.isLoginSuccess {
            MainTabView()
        } else {
            LoginView(viewModel: $loginViewModel)
        }
    }
}

#Preview {
    ContentView()
}
