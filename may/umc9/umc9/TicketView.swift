//
//  TicketView.swift
//  umc9_wb
//
//  Created by 백지은 on 9/20/25.
//

import SwiftUI

// 1주차 실습

struct TicketView: View {
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(Color.black.opacity(0.3))
                .frame(width: 385, height: 385)
            
            VStack{
                Spacer().frame(height: 111)
                mainTitleGroup
                Spacer().frame(height: 138)
                mainBottomGroup
                Spacer().frame(height: 13)
            }
        }
        .padding()
    }
    
    private var mainTitleGroup: some View {
        VStack {
            Group {
                Text("마이펫의 이중생활2")
                    .font(.bold30)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .padding(3)
                Text("본인 + 동반 1인")
                    .font(.light16)
                Text("30,100원")
                    .font(.bold24)
            }
            .foregroundStyle(Color.white)
        }
        .frame(height: 84)
    }
    
    private var mainBottomGroup: some View {
        Button(action: {
            print("Hello")
        }, label: {
            VStack {
                Image(systemName: "chevron.up")
                    .resizable()
                    .frame(width: 18, height: 12)
                Spacer().frame(height:7)
                Text("예매하기")
                    .font(.semiBold18)
            }
            .foregroundStyle(Color.white)
            .opacity(0.4)
            .frame(width: 63, height: 40)
        })
    }
}

#Preview {
    TicketView()
}

