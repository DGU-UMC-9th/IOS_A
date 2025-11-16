//
//  TabSectionView.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI

struct TabSectionView: View {
    @EnvironmentObject var model: LoginViewModel
    
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house.fill") {
                HomeView()
            }
            Tab("바로 예매", systemImage: "ticket") {
                MovieBookingView()
            }
            Tab("모바일 오더", systemImage: "popcorn") {
                
            }
            Tab("마이페이지", systemImage: "person") {
                UserInfoView()
                    .environmentObject(model)
            }
        }
    }
}

#Preview {
    TabSectionView()
        .environmentObject(LoginViewModel())
}
