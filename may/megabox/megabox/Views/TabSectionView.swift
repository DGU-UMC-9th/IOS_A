//
//  TabSectionView.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI

struct TabSectionView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
            HomeView()
                .tabItem {
                    Image(systemName: "ticket")
                    Text("바로 예매")
                }
            HomeView()
                .tabItem {
                    Image(systemName: "popcorn")
                    Text("모바일 오더")
                }
            UserInfoView()
                .tabItem {
                    Image(systemName: "person")
                    Text("마이페이지")
                }
        }
    }
}

#Preview {
    TabSectionView()
}
