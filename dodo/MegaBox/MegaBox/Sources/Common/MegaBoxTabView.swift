//
//  MegaBoxTabView.swift
//  MegaBox
//
//  Created by 김도연 on 9/29/25.
//

import SwiftUI

struct MegaBoxTabView: View {
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house") {
                HomeView()
            }
            
            Tab("바로 예매", systemImage: "play.laptopcomputer") {
                
            }
            
            Tab("모바일 오더", systemImage: "popcorn") {
                
            }
            
            Tab("마이 페이지", systemImage: "person") {
                
            }
        }
        .tint(.purple03)
    }
}

#Preview {
    MegaBoxTabView()
}
