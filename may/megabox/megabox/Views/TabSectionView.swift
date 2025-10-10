//
//  TabSectionView.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI

struct TabSectionView: View {
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house.fill") {
                HomeView()
            }
            Tab("바로 예매", systemImage: "ticket") {
                HomeView()
            }
            Tab("모바일 오더", systemImage: "popcorn") {
                HomeView()
            }
            Tab("마이페이지", systemImage: "person") {
                UserInfoView()
            }
        }
    }
}

#Preview {
    TabSectionView()
}
