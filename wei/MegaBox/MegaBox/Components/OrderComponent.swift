//
//  OrderComponent.swift
//  MegaBox
//
//  Created by 이연우 on 11/25/25.
//

import Foundation
import SwiftUI

struct TheaterSelectionBar: View {
    let theaterName: String
    let action: () -> Void

    var body: some View {
        HStack {
            Image("pinIcon")
            Text(theaterName)
                .font(.semiBold13)

            Spacer()

            Button(action: action) {
                Text("극장 변경")
                    .font(.semiBold13)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.primary, lineWidth: 1)
                    )

                   
            }
        }
        .padding()
    }
}


struct PurpleTheaterBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .background(Color.purple03)
    }
}

extension View {
    func purpleTheaterBar() -> some View {
        self.modifier(PurpleTheaterBarStyle())
    }
}


struct WhiteTheaterBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .background(Color.white)
    }
}

extension View {
    func whiteTheaterBar() -> some View {
        self.modifier(WhiteTheaterBarStyle())
    }
}


struct MenuCard : View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()

            Text(item.name)
                .font(.regular12)
                .foregroundStyle(Color.black)

            Text("\(item.price)원")
                .font(.regular12)
                .foregroundStyle(Color.black)
        }
        .padding()
        .background(.white)
        .cornerRadius(12)
        
    }
}

struct ShowBestBadge: ViewModifier {
    let isBest: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content
            
            if isBest {
                Text("BEST")
                    .font(.semiBold12)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red)
                    .cornerRadius(6)
                    .padding(8)
            }
        }
    }
}

struct ShowRecommendBadge: ViewModifier {
    let isRecommended: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content
            
            if isRecommended {
                Text("추천")
                    .font(.caption2.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .cornerRadius(6)
                    .padding(8)
            }
        }
    }
}

struct SoldOutModifier: ViewModifier {
    let isSoldOut: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .opacity(isSoldOut ? 0.4 : 1.0)
            
            if isSoldOut {
                Text("품절")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(12)
            }
        }
    }
}

struct DiscountModifier: ViewModifier {
    let price : Int?
    let discountRate: Int?
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
        }
    }
}

struct CardShadowModifier: ViewModifier {
    let enabled: Bool
    
    func body(content: Content) -> some View {
        if enabled {
            content
                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 2)
        } else {
            content
        }
    }
}


