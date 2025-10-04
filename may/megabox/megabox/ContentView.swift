//
//  ContentView.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var model = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            if model.isLogined {
                TabSectionView()
                    .transition(.opacity)
            } else {
                LoginView(model: model)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: model.isLogined)
    }
}

#Preview {
    ContentView()
}
