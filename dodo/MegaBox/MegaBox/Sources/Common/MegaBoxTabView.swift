//
//  MegaBoxTabView.swift
//  MegaBox
//
//  Created by 김도연 on 9/29/25.
//

import SwiftUI

struct MegaBoxTabView: View {
    @State private var homeViewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house") {
                HomeView()
                    .environment(homeViewModel) // HomeViewModel을 Environment로 전달
            }
            
            Tab("바로 예매", systemImage: "play.laptopcomputer") {
                BookingView()
            }
            
            Tab("모바일 오더", systemImage: "popcorn") {
                OrderView()
            }
            
            Tab("마이 페이지", systemImage: "person") {
                UserInfoView()
            }
        }
        .tint(.purple03)
    }
}

#Preview {
    MegaBoxTabView()
}
