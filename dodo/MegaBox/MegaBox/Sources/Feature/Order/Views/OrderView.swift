//
//  OrderView.swift
//  MegaBox
//
//  Created by 김도연 on 11/21/25.
//

import SwiftUI

struct OrderView: View {
    @State private var vm = OrderViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Image(.megaBoxSmallLogo)
                        .padding([.leading, .vertical])
                    ChangeTheater()
                    ScrollView {
                        VStack(spacing: 24) {
                            orderSection(geometry: geometry)
                            menuListSection(title: "추천 메뉴", subTitle: "영화 볼 때 뭐먹지 고민될 땐 추천 메뉴!", items: vm.menuList)
                            menuListSection(title: "베스트 메뉴", subTitle: "영화 볼 때 뭐먹지 고민될 때 베스트 메뉴!", items: vm.menuList)
                        }
                    }
                }
            }
        }
    }
    
    func orderSection(geometry: GeometryProxy) -> some View {
        let screenWidth = geometry.size.width
        let padding: CGFloat = screenWidth * 0.04
        
        // 음수일 경우 오류 발생 -> 해결위해 max로 최저값 잡아주기
        let availableWidth = max(0, screenWidth - (padding * 2))
        let largeCardWidth = max(0, availableWidth * 0.6)
        let smallCardWidth = max(0, availableWidth - largeCardWidth - 8)
        
        let largeCardHeight = max(0, screenWidth * 0.8)
        let smallCardHeight = max(0, (largeCardHeight - 8) / 2)
        let deliveryCardHeight = max(0, screenWidth * 0.32)
        
        return VStack {
            HStack {
                NavigationLink {
                    OrderNowView(vm: vm)
                } label: {
                    OrderCard(
                        title: "바로 주문",
                        subTitle: "이제 줄서지 말고 \n모바일로 주문하고 픽업!",
                        image: Image(systemName: "popcorn"),
                        width: largeCardWidth,
                        height: largeCardHeight
                    )
                }
                .buttonStyle(.plain) //NavigationLink로 하면 subTitle alignment가 중앙정렬되어서 leading으로 맞추기

                VStack {
                    OrderCard(
                        title: "스토어 교환권",
                        subTitle: nil,
                        image: Image(systemName: "ticket"),
                        width: smallCardWidth,
                        height: smallCardHeight
                    )
                    OrderCard(
                        title: "선물하기",
                        subTitle: nil,
                        image: Image(systemName: "gift"),
                        width: smallCardWidth,
                        height: smallCardHeight
                    )
                }
            }
            OrderCard(
                title: "어디서든 팝콘 만나기",
                subTitle: "팝콘 콜라 스낵 모든 메뉴 배달 가능!",
                image: Image(systemName: "motorcycle"),
                width: availableWidth,
                height: deliveryCardHeight
            )
        }
    }
    
    func menuListSection(title: String, subTitle: String, items: [MenuItemModel]) -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.bold18)
                Text(subTitle)
                    .font(.regular12)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
        
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(items, id: \.title) { menu in
                        MenuCard(menu: menu, showOverlays: false)
                            .padding(.bottom)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    OrderView()
}
