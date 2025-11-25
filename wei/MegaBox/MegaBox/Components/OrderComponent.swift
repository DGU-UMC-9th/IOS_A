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
                .foregroundColor(.white)
                .font(.headline)

            Spacer()

            Button(action: action) {
                Text("극장 변경")
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.clear)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 1)
                    )

                   
            }
        }
        .padding()
        .background(Color.purple03)
    }
}


struct MenuCard : View {
    let item: MenuItemModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()

            Text(item.name)
                .font(.regular12)

            Text("\(item.price)원")
                .font(.regular12)
                .foregroundStyle(Color.black)
        }
        .padding()
        .background(.white)
        .cornerRadius(12)
        
    }
}

