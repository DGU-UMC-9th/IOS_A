//
//  ContentView.swift
//  MegaBox
//
//  Created by 김도연 on 9/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.isAuthenticated {
                MegaBoxTabView()
                    .transition(.opacity)
            } else {
                LoginView(vm: viewModel)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.isAuthenticated)
    }
}

#Preview {
    ContentView()
}
