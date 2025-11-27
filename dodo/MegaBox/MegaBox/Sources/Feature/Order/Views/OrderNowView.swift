//
//  OrderNowView.swift
//  MegaBox
//
//  Created by 김도연 on 11/23/25.
//

import SwiftUI

struct OrderNowView: View {
    @State var vm : OrderViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack {
            ChangeTheater(theaterName: "강남",isWhite: true, action: {print("강남")})
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(vm.menuList, id: \.title) { menu in
                        MenuCard(menu: menu)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("바로주문")
                    .font(.semiBold24)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "cart")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        OrderNowView(vm: OrderViewModel())
    }
}
