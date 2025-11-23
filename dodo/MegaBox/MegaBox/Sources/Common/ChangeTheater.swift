//
//  ChangeTheater.swift
//  MegaBox
//
//  Created by 김도연 on 11/21/25.
//

import SwiftUI

struct ChangeTheater: View {
    var isWhite: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(.locator)
                .renderingMode(.template)
                .foregroundStyle(isWhite ? .black : .white)
            Text("강남")
                .foregroundStyle(isWhite ? .black : .white)
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
    }
}

//MARK: - 이경표가 불편하대요;;;
#Preview {
    VStack(alignment: .leading) {
        Image(.megaBoxSmallLogo)
            .padding(.leading)
        ChangeTheater(isWhite: true)
        Spacer()
    }
}
