//
//  MobileOrderDetailView.swift
//  Megabox
//
//  Created by 송민교 on 11/22/25.
//

import SwiftUI

struct MobileOrderDetailView: View {
    @Environment(NavigationRouterViewModel.self) private var router
    
    // MARK: headerSection
    // model
    let locationModel = LocationSelectBarModel(theaterLocation: TheaterType.gangnam, buttonText: "극장 변경", onAction: {}, style: .secondary)
    
    // MARK: bodySection
    // menu
    let menuItemsModel : [MenuItemModel] = [
        MenuItemModel(
            menuImage: "singlePackage", menuName: "싱글 콤보", menuPrice: "10,900원",
            isBest: true
        ),
        MenuItemModel(
            menuImage: "loveCombo", menuName: "러브 콤보", menuPrice: "12,900원",
            isBest: true
        ),
        MenuItemModel(menuImage: "doubleCombo", menuName: "더블 콤보", menuPrice: "24,900원",
            isBest: true
        ),
        MenuItemModel(menuImage: "loveComboPackage", menuName: "러브 콤보 패키지", menuPrice: "32,000원"),
        MenuItemModel(menuImage: "familyComboPackage", menuName: "패밀리 콤보 패키지", menuPrice: "47,000원"),
        MenuItemModel(menuImage: "ticketBook", menuName: "메가박스 오리지널 티켓북 시즌4 돌비시네마 에디션 단품", menuPrice: "10,900원",
            isRecommended: true
        ),
        MenuItemModel(menuImage: "disney", menuName: "디즈니 픽사 포스터", menuPrice: "15,900원",
            isSoldOut: true
        ),
        MenuItemModel(menuImage: "insideout", menuName: "인사이드아웃2 감정", menuPrice: "29,900원", originalPrice: "35,000원")
    ]
    
    // 2열 레이아웃 정의
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack{
            headerSection
            bodySection
        }
        .navigationTitle("바로주문")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button(action:{}){
                    Image(systemName: "cart")
                        .foregroundStyle(Color.black)
                }
            }
        }
        .toolbarTitleDisplayMode(.inline)
    }
    
    
    var headerSection: some View {
        VStack{
            LocationSelectBar(model: locationModel)
        }
    }
    
    var bodySection: some View{
        ScrollView{
            LazyVGrid(columns: columns, spacing: 30){
                ForEach(menuItemsModel){ item in
                    MenuItem(model: item)
                }
            }
            .padding(.horizontal, 36)
        }
    }
}

#Preview {
    MobileOrderDetailView()
        .environment(NavigationRouterViewModel())
}
