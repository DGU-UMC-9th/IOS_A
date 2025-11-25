//
//  OrderInfoView.swift
//  MegaBox
//
//  Created by 이연우 on 11/25/25.
//

import Foundation
import SwiftUI

struct OrderInfoView : View {
    
    let items = [
        MenuItemModel(name: "싱글 콤보", price: 10900, imageName: "menu3"),
        MenuItemModel(name: "러브 콤보", price: 10900, imageName: "menu1"),
        MenuItemModel(name: "더블 콤보", price: 24900, imageName: "menu2"),
        MenuItemModel(name: "러브 콤보 패키지", price: 32000, imageName: "menu4"),
        MenuItemModel(name: "패밀리 콤보 패키지", price: 47000, imageName: "menu8"),
        MenuItemModel(name: "메가박스 오리지널 티켓북 시즌4 돌비시네마 에디션 단품", price: 10900, imageName: "menu6"),
        MenuItemModel(name: "디즈니 픽사 포스터", price: 15900, imageName: "menu5"),
        MenuItemModel(name: "인사이드아웃2 감정", price: 35000, imageName: "menu7"),
    ]
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

               
                TheaterSelectionBar(theaterName: "강남") {}
                    .whiteTheaterBar()
                    .padding(.horizontal, 16)

                
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(items) { item in
                        MenuCard(item: item)
//                            .bestBadge(item.isBest)
//                            .recommendBadge(item.isRecommended)
//                            .discountBadge(item.discountRate)
//                            .soldOut(item.isSoldOut)
                    }
                }
                .padding(.horizontal, 16)
                
            }
            .padding(.top, 16)
        }
    }
}
