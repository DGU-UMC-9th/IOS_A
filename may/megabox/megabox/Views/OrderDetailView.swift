//
//  OrderDetailView.swift
//  megabox
//
//  Created by 백지은 on 11/22/25.
//

import SwiftUI

struct OrderDetailView: View {
    @StateObject private var viewModel = MobileOrderViewModel()
    @State private var theaterName = "강남"
    
    var body: some View {
        VStack{
            TheaterBar(theaterName: theaterName, onChange: {})
                .modifier(DetailViewStyle())
            Divider()
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 20),
                    GridItem(.flexible(), spacing: 20)
                ], spacing: 20) {
                    ForEach(viewModel.menuItems) { item in
                        MenuCard(item: item)
                            .modifier(MenuBadgeModifier(badge: item.badge, isSoldOut: item.isSoldOut))
                            .largeMenuCardStyle()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
        }
        .navigationBarBackButtonHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("바로주문")
                        .font(.bold18)
                        .foregroundColor(.black)
                    Spacer()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "cart")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct MenuBadgeModifier: ViewModifier {
    let badge: MenuBadge?
    let isSoldOut: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            content
            
            // Badge
            if let badge = badge {
                Text(badge == .best ? "BEST" : "추천")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        badge == .best ? Color.red : Color.blue
                    )
                    .cornerRadius(5)
            }
        }
    }
}

#Preview {
    NavigationView {
        OrderDetailView()
    }
}
