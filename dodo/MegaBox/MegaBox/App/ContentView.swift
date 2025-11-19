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
        if viewModel.isAuthenticated {
            MegaBoxTabView()
        } else {
            LoginView(vm: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
