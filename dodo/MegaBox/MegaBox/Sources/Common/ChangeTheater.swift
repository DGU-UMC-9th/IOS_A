//
//  ChangeTheater.swift
//  MegaBox
//
//  Created by 김도연 on 11/21/25.
//

import SwiftUI

struct ChangeTheater: View {
    let theaterName: String
    var isWhite: Bool = false
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(.locator)
                .renderingMode(.template)
            Text("강남")
            Spacer()
            Button {
                
            } label: {
                Text("극장 변경")
                    .foregroundStyle(isWhite ? .purple03 : .white)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isWhite ? .black : .white)
                        )
            }
        }
        .font(.semiBold13)
        .padding(12)
        .background(isWhite ? .white : .purple03)
        .foregroundStyle(isWhite ? .black : .white)
    }
}

//MARK: - 이경표가 불편하대요;;;
#Preview {
    VStack(alignment: .leading) {
        Image(.megaBoxSmallLogo)
            .padding(.leading)
        ChangeTheater(
            theaterName: "강남",
            isWhite: false,
            action: { print("purple") }
        )
        ChangeTheater(
            theaterName: "강남",
            isWhite: true,
            action: { print("white") }
        )
        Spacer()
    }
}
