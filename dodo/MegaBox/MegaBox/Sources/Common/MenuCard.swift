//
//  MenuCard.swift
//  MegaBox
//
//  Created by 김도연 on 11/21/25.
//

import SwiftUI

// MARK: - ViewModifiers
struct BadgeModifier: ViewModifier {
    let badge: BadgeType?
    
    func body(content: Content) -> some View {
        content.overlay(alignment: .topLeading) {
            if let badge = badge {
                Text(badge.title)
                    .font(.regular12)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(badge.backgroundColor)
            }
        }
    }
}

struct SoldOutModifier: ViewModifier {
    let isAvailable: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if !isAvailable {
                Color.black.opacity(0.6)
                Text("품절")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension View {
    func badgeOverlay(badge: BadgeType?) -> some View {
        self.modifier(BadgeModifier(badge: badge))
    }
    
    func soldOutOverlay(isAvailable: Bool) -> some View {
        self.modifier(SoldOutModifier(isAvailable: isAvailable))
    }
}

// MARK: - MenuCard
struct MenuCard: View {
    let menu: MenuItemModel
    var showOverlays: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(menu.image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .badgeOverlay(badge: showOverlays ? menu.badge : nil)
                .soldOutOverlay(isAvailable: showOverlays ? menu.isAvailable : true)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(menu.title)
                    .font(.system(size: 14))
                    .foregroundStyle(menu.isAvailable ? .black : .gray)
                    .lineLimit(1)
                
                if let salesPrice = menu.salesPrice {
                    HStack(spacing: 4) {
                        Text(salesPrice)
                            .font(.system(size: 16, weight: .bold))
                        
                        Text(menu.price)
                            .font(.caption)
                            .strikethrough()
                            .foregroundStyle(.gray)
                    }
                } else {
                    Text(menu.price)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(menu.isAvailable ? .black : .gray)
                }
            }
        }
    }
}

struct OrderCard: View {
    let title: String
    let subTitle: String?
    let image: Image
    let width: Double
    let height: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .stroke(.gray02)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.bold22)
                    .lineLimit(2)
                
                Text(subTitle ?? "")
                    .font(.regular12)
                
                Spacer()
                
                HStack {
                    Spacer()
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
            }
            .padding()
        }
        //Invalid frame dimension (negative or non-finite) 이거 방지
        .frame(width: max(0, width), height: max(0, height))
    }
}

#Preview {
    MenuCard(menu: OrderViewModel().menuList[0])
    OrderCard(title: "바로주문", subTitle: "이제 줄서지 말고 \n모바일로 주문하고 픽업!", image: Image(systemName: "popcorn"), width: 232, height: 308)
}
