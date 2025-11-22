//
//  MobileOrderView.swift
//  megabox
//
//  Created by 백지은 on 11/22/25.
//

import SwiftUI

struct MobileOrderView: View {
    
    @StateObject private var viewModel = MobileOrderViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15){
                HeaderSection
                TheaterBar(theaterName: "강남", onChange: {})
                    .modifier(OrderViewStyle())
                ButtonSection
                
                recommendedMenuSection
                bestMenuSection
                
            }
        }
    }   
    
    private var HeaderSection: some View {
        HStack{
            Image(.meboxHeader)
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private var ButtonSection: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                NavigationLink(destination: OrderDetailView()) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("바로 주문")
                            .font(.bold22)
                            .foregroundColor(.black)
                        
                        Text("이제 줄서지 말고\n모바일로 주문하고 픽업!")
                            .font(.regular12)
                            .foregroundColor(.gray04)
                            .lineSpacing(2)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Image(systemName: "popcorn")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30)
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(20)
                    .frame(height: 308)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray02)
                    )
                }
                
                VStack(spacing: 8) {
                    NavigationLink(destination: OrderDetailView()) {
                        VStack(alignment: .leading, spacing:20) {
                            Text("스토어 교환권")
                                .font(.bold22)
                                .foregroundColor(.black)
                                .padding(.bottom, 8)
                            HStack{
                                Spacer()
                                Image(.ticket)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:50, height:50)
                            }
                        }
                        .padding(10)
                        .frame(width: 150, height: 150)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray02)
                        )
                    }
                    
                    NavigationLink(destination: OrderDetailView()) {
                        VStack(alignment: .leading, spacing:20) {
                            Text("선물하기")
                                .font(.bold22)
                                .foregroundColor(.black)
                                .padding(.bottom, 8)
                            HStack{
                                Spacer()
                                Image(.present)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:50, height:50)
                            }
                        }
                        .padding(10)
                        .frame(width: 150, height: 150)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray02)
                        )
                    }
                }
            }
            
            NavigationLink(destination: OrderDetailView()) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("어디서든 팝콘 만나기")
                            .font(.bold22)
                            .foregroundColor(.black)
                        Text("팝콘 클라우드 모든 매뉴 배달 가능!")
                            .font(.regular12)
                            .foregroundColor(.gray04)
                    }
                    
                    Spacer()
                    
                    Image(.motorcycle)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50, height:50)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray02)
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
    
    private var recommendedMenuSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("추천 메뉴")
                .font(.bold22)
                .padding(.horizontal, 16)
            
            Text("영화 볼 때 뭐 먹지 고민될 땐 추천 메뉴!")
                .font(.regular12)
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.getRecommendedMenuItems()) { item in
                        MenuCard(item: item)
                            .smallMenuCardStyle()
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.vertical, 10)
    }
    
    private var bestMenuSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("베스트 메뉴")
                .font(.bold22)
                .padding(.horizontal, 16)
            
            Text("영화 볼 때 뭐 먹지 고민될 땐 베스트 메뉴!")
                .font(.regular12)
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.getBestMenuItems()) { item in
                        MenuCard(item: item)
                            .smallMenuCardStyle()
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    NavigationStack {
        MobileOrderView()
    }
}
