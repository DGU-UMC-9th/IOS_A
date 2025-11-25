//
//  MobileOrderView.swift
//  Megabox
//
//  Created by 송민교 on 10/4/25.
//

import SwiftUI

struct MobileOrderView : View {
    @Environment(NavigationRouterViewModel.self) private var router
    // MARK: bodySection
    // model
    let storeChange = OrderButtonModel(title: "스토어 교환권", description: "", iconName: "ticket", action: {})
    let gift = OrderButtonModel(title: "선물하기", description: "", iconName: "gift", action: {})
    let delivery = OrderButtonModel(title: "어디서든 팝콘 만나기", description: "팝콘 놀라 스낵 모든 메뉴 배달 가능!", iconName: "bicycle", action: {})
    
    // MARK: bottomSection
    // menu
    let recommendedItems: [MenuItemModel] = [
         MenuItemModel(menuImage: "loveCombo", menuName: "러브 콤보", menuPrice: "10,900원"),
         MenuItemModel(menuImage: "doubleCombo", menuName: "더블 콤보", menuPrice: "24,900원"),
        MenuItemModel(menuImage: "disney", menuName: "디즈니 픽사 포토카드", menuPrice: "15,900원")
    ]
    let bestItems: [MenuItemModel] = [
        MenuItemModel(menuImage: "singlePackage", menuName: "싱글 패키지", menuPrice: "12,900원"),
        MenuItemModel(menuImage: "doubleCombo", menuName: "더블 콤보", menuPrice: "24,900원"),
        MenuItemModel(menuImage: "loveComboPackage", menuName: "러브 콤보 패키지", menuPrice: "34,900원")
    ]
    
    var body: some View{
        ScrollView{
            VStack {
                headerSection
                bodySection
                bottomSection
            }
        }
    }
    
    var headerSection: some View {
        VStack(alignment: .leading){
            Image("meboxHomeLogo")
                .resizable()
                .aspectRatio(contentMode: .fit) // 비율 유지하며 맞추기
                .frame(width: 149, height: 30)
                .padding(.leading,30)
            LocationSelectBar(model: LocationSelectBarModel(
                theaterLocation: TheaterType.gangnam,
                buttonText: "극장 변경",
                onAction: {print("극장변경")},
                style: .primary
            ))
        }
    }
    
    var bodySection: some View {
        // model
        let orderModel = OrderButtonModel(
            title: "바로 주문",
            description: "이제 줄서지 말고 \n모바일로 주문하고 픽업!",
            iconName: "popcorn",
            action: {
                router.push(.detailOrder)
            })
        
        return VStack(spacing:60){
            HStack(spacing: 15){
                OrderButton(model: orderModel)
                    .frame(height: 330)
                VStack(spacing:10){
                    OrderButton(model: storeChange)
                        .frame(height: 160)
                    OrderButton(model: gift)
                        .frame(height: 160)
                }
            }
            
            VStack{
                OrderButton(model: delivery)
                    .frame(height: 60)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(30)
    }
    
    var bottomSection: some View {
        VStack(spacing: 30){
            // MARK: 추천 메뉴
            VStack(alignment: .leading, spacing: 10){
                Text("추천 메뉴")
                    .font(.pretend(type: .bold, size: 22))
                Text("영화 볼 때 뭐 먹지 고민될 땐 추천 메뉴!")
                    .font(.pretend(type: .light, size: 12))
                    .foregroundStyle(Color.gray06)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing:20){
                        ForEach(recommendedItems){ item in
                            MenuItem(model: item)
                        }
                    }
                }
            }
            
            // MARK: 베스트 메뉴
            VStack(alignment: .leading, spacing: 10) {
                Text("베스트 메뉴")
                    .font(.pretend(type: .bold, size: 22))
                Text("영화 볼 때 뭐 먹지 고민될 땐 베스트 메뉴!")
                    .font(.pretend(type: .light, size: 12))
                    .foregroundStyle(Color.gray06)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing:20){
                        ForEach(bestItems){ item in
                            MenuItem(model: item)
                        }
                    }
                }
            }
        }
        .padding(.top, 30)
        .padding(.leading, 40)
    }
}

#Preview {
    MobileOrderView()
        .environment(NavigationRouterViewModel())
}
