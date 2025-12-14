//
//  MenuCard.swift
//  megabox
//
//  Created by 백지은 on 11/22/25.
//

import SwiftUI

struct MenuCard: View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                item.image
                    .resizable()
                    .scaledToFit()
                    .background(Color.gray01)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                if item.isSoldOut {
                    ZStack {
                        Color.black.opacity(0.8)
                        Text("품절")
                            .font(.medium14)
                            .foregroundColor(.white)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            Spacer()
                .frame(height:12)
            
            Text(item.title)
                .font(.regular13)
                .lineLimit(1)
            
            Text("\(item.price)원")
                .font(.semiBold14)
        }
    }
}

struct MenuCardSmallStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 152, height: 152 + 12 + 13 + 14 + 8) // 이미지 + Spacer + 텍스트 높이 합산
    }
}

struct MenuCardLargeStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 170, height: 170 + 12 + 13 + 14 + 8)
    }
}

extension View {
    func smallMenuCardStyle() -> some View {
        self.modifier(MenuCardSmallStyle())
    }
    
    func largeMenuCardStyle() -> some View {
        self.modifier(MenuCardLargeStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        MenuCard(item: MenuItemModel(title: "러브콤보", price: 30000, image: Image(.loveCombo), badge: nil, isSoldOut: false))
            .smallMenuCardStyle()
        
        MenuCard(item: MenuItemModel(title: "러브콤보", price: 30000, image: Image(.loveCombo), badge: nil, isSoldOut: false))
            .largeMenuCardStyle()
    }
}
