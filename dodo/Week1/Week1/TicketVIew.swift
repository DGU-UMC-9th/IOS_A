//
//  TicketVIew.swift
//  Week1
//
//  Created by 김도연 on 9/15/25.
//

import SwiftUI

struct TicketView: View {
    var body: some View {
        ZStack {
            Image(.ticket)
            VStack(spacing: 138) {
                mainTitleGroup
                mainBottomGroup
            }
        }
        .padding()
    }
    
    /// 상단 Title VStack
    private var mainTitleGroup: some View {
        VStack {
            Group {
                Text("마이펫의 이중생활2")
                    .font(.bold30)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                Text("본인 + 동반 1인")
                    .font(.light16)
                Text("30,100원")
                    .font(.bold24)
            }
            .foregroundStyle(Color.white)
        }
        .frame(height: 84)
        .padding(.top, 94)
    }
    
    private var mainBottomGroup: some View {
        Button {
            print("Hello")
        } label: {
            VStack {
                Image(systemName: "chevron.up")
                    .resizable()
                    .frame(width: 18, height: 12)
                    .tint(.white)
                Text("예매하기")
                    .font(.semiBold18)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 63, height: 40)
        }
    }
}

#Preview {
    TicketView()
}
