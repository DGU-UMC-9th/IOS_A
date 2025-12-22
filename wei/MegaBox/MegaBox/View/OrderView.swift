//
//  OrderView.swift
//  MegaBox
//
//  Created by 이연우 on 11/25/25.
//

import Foundation
import SwiftUI

struct OrderView: View {
    
    @State private var selectedTheater = "강남"
    @Binding var path: NavigationPath
    
    // 샘플 데이터
    let recommendItems = [
        MenuItemModel(name: "러브 콤보", price: 10900, imageName: "menu1"),
        MenuItemModel(name: "더블 콤보", price: 24900, imageName: "menu2"),
        MenuItemModel(name: "디즈니 픽사 포스터", price: 15900, imageName: "menu5")
    ]
    
    let bestItems = [
        MenuItemModel(name: "싱글 패키지", price: 8900, imageName: "menu3"),
        MenuItemModel(name: "더블 콤보", price: 24900, imageName: "menu1"),
        MenuItemModel(name: "러브 콤보 패키지", price: 19900, imageName: "menu4")
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                
                headerView
                
                theaterBar
                
                selectionView
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                RecommendMenuView
                    .padding(.top, 24)
                
                BestMenuView
                    .padding(.top, 24)
                    .padding(.bottom, 100)
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Image("meBoxLogo 1") // 메가박스 로고
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .padding(.leading, 16)
            Spacer()
        }
        .frame(height: 60)
        //.background(Color.white)
    }
    
    // 극장 선택 바
    private var theaterBar: some View {
        TheaterSelectionBar(theaterName: selectedTheater) {
                
                print("극장 변경 버튼 탭")
            }
        .PurpleTheaterBarStyle()
    }
    
    // 선택 카드 영역
    private var selectionView: some View {
        VStack(spacing: 12) {
            
            HStack(spacing: 12) {
                
                selectionCard(
                    title: "바로 주문",
                    info: "이제 줄서서 말고\n모바일로 주문하고 픽업!",
                    icon: "popcornIcon",
                    isWide: true
                )
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray02, lineWidth: 1)
                )

                
                
                VStack(spacing: 10) {
                    selectionCard(
                        title: "스토어 교환권",
                        info: "",
                        icon: "ticketIcon",
                        isWide: false
                    )
                    .frame(height: 97)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray02, lineWidth: 1)
                    )
                    
                    selectionCard(
                        title: "선물하기",
                        info: "",
                        icon: "giftIcon",
                        isWide: false
                    )
                    .frame(height: 97)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray02, lineWidth: 1)
                    )
                }
                .frame(maxWidth: .infinity)
                
            }
            
            // 하단 카드 (어디서든 팝콘 만나기)
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("어디서든 팝콘 만나기")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("팝콘 콜라 스낵 모든 메뉴 배달 가능!")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image("deliverIcon")
                    .font(.system(size: 40))
                    
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray02, lineWidth: 1)
            )
        }
    }
        
    
    // 선택 카드 컴포넌트
    private func selectionCard(title: String, info: String, icon: String, isWide: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            if !info.isEmpty {
                Text(info)
                    .font(.caption)
                    .foregroundColor(.gray03)
                    .lineLimit(2)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Image(icon)
                    .font(.system(size: 40))
                    .foregroundColor(.purple.opacity(0.3))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        
    }
    
    // 추천 메뉴 섹션
    private var RecommendMenuView: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                Text("추천 메뉴")
                    .font(.bold22)
                    .foregroundColor(.black)
                Text("영화 볼때 뭐먹지 고민될 땐 추천 메뉴!")
                    .font(.regular12)
                    .foregroundColor(.gray03)
            }
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(recommendItems) { item in
                        MenuCard(item: item)
                            .frame(width: 140, height: 220)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    // 베스트 메뉴 섹션
    private var BestMenuView: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                Text("베스트 메뉴")
                    .font(.bold22)
                    .foregroundColor(.black)
                Text("영화 볼때 뭐먹지 고민될 땐 베스트 메뉴!")
                    .font(.regular12)
                    .foregroundColor(.gray03)
            }
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(bestItems) { item in
                        MenuCard(item: item)
                            .frame(width: 140)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

//#Preview {
//    OrderView()
//}
