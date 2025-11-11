//
//  MainTapView.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation
import SwiftUI


struct MainTabView: View {
    @State var viewModel: LoginViewModel
    
    var body: some View {
        TabView {
            HomeTab()
                .tabItem { Label("홈", systemImage: "house") }
            
            TicketTab()
                .tabItem{Label("바로 예매", systemImage: "play.laptopcomputer") }
            
            OrderTab()
                .tabItem { Label("모바일 오더", systemImage: "popcorn") }
            
            InfoTab(viewModel: viewModel)
                .tabItem { Label("마이 페이지", systemImage: "person") }
            
            
        }
    }
}

struct HomeTab: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
        }
    }
}

struct InfoTab: View {
    @State var viewModel: LoginViewModel
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            InfoView(viewModel: viewModel, path: $path)
        }
    }
}

struct TicketTab : View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ReserveView(path: $path)
        }
    }
}

struct OrderTab : View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
        }
    }
}

//
//#Preview {
//    MainTabView()
//}
