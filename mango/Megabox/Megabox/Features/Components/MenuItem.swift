//
//  MenuItemModel.swift
//  Megabox
//
//  Created by 송민교 on 11/22/25.
//


import SwiftUI

struct MenuItemModel: Identifiable{
    let id = UUID()
    var menuImage: String
    var menuName: String
    var menuPrice: String // 현재 판매 가격 (정가 or 할인가)
    var originalPrice: String? = nil // 원래 가격 (취소선)
    
    var isBest: Bool = false
    var isRecommended: Bool = false
    var isSoldOut: Bool = false
}

struct MenuItem: View {
    var model: MenuItemModel
    
    var menuImageView: some View{
        Image(model.menuImage)
            .resizable()
            .frame(width: 152, height: 152)
            .cornerRadius(8)
    }
    
    var body: some View {
        VStack(spacing:12){
            menuImageView
                .frame(width: 190, height: 190)
                .background(Color.gray01.opacity(0.5))
                .cornerRadius(12)
                .bestBadge(isBest: model.isBest)
                .recommendedBadge(isRecommended: model.isRecommended)
                .soldOut(isSoldOut: model.isSoldOut)
            
            VStack(alignment: .leading){
                Text(model.menuName)
                    .font(.pretend(type: .light, size: 13))
                
                if let original = model.originalPrice{
                    HStack(spacing: 8){
                        Text(model.menuPrice)
                            .font(.pretend(type: .semibold, size: 14))
                        
                        Text(original)
                            .font(.pretend(type: .light, size: 9))
                            .foregroundStyle(Color.gray06)
                            .strikethrough(true)
                        }
                    } else {
                        Text(model.menuPrice)
                            .font(.pretend(type: .semibold, size: 14))
                }
            }
            .frame(width:190, alignment: .leading)
        }
    }
    
}

struct BestBadgeModifier: ViewModifier{
    let isBest: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topLeading){
                if isBest{
                    Text("BEST")
                        .font(.pretend(type: .semibold, size: 12))
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Color(red: 0.93, green: 0.3, blue: 0.34)
                                .cornerRadius(4)
                        )
                }
            }
    }
}

struct RecommendedModifier: ViewModifier{
    let isRecommended: Bool
    
    func body(content: Content)-> some View{
        content
            .overlay(alignment: .topLeading){
                if isRecommended{
                    Text("추천")
                        .font(.pretend(type: .semibold, size: 12))
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Color(red: 0.14, green: 0.48, blue: 0.79)
                        )
                }
            }
    }
}

struct SoldOutModifier: ViewModifier {
    let isSoldOut: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay{
                if isSoldOut{
                    Color.black.opacity(0.8)
                        .cornerRadius(8)
                        .overlay{
                            Text("품절")
                                .font(.pretend(type: .semibold, size: 14))
                                .foregroundStyle(Color.white)
                        }
                }
            }
    }
}

extension View {
    func bestBadge(isBest: Bool) -> some View {
        self.modifier(BestBadgeModifier(isBest: isBest))
    }
    
    func recommendedBadge(isRecommended: Bool) -> some View {
        self.modifier(RecommendedModifier(isRecommended: isRecommended))
    }
    
    func soldOut(isSoldOut: Bool) -> some View {
        self.modifier(SoldOutModifier(isSoldOut: isSoldOut))
    }
}

#Preview {
    MenuItem(model: MenuItemModel(
        menuImage: "doubleCombo", menuName: "더블 콤보", menuPrice: "10,900원",originalPrice: "30,000원",
        isBest: true,
    ))
    MenuItem(model: MenuItemModel(
        menuImage: "doubleCombo", menuName: "더블 콤보", menuPrice: "10,900원",
        isSoldOut: true
    ))
}

