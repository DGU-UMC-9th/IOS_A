//
//  LocationSelectBar.swift
//  Megabox
//
//  Created by 송민교 on 11/22/25.
//
import SwiftUI

struct LocationSelectBarModel{
    var theaterLocation: TheaterType
    var buttonText: String
    var onAction: () -> Void
    var style: LocationSelectBarStyle
}

struct LocationSelectBarStyle{
    let backgroundColor: Color
    let contentColor: Color
    let buttonBorderColor: Color
    let buttonTextColor: Color
    
    static let primary = LocationSelectBarStyle(
        backgroundColor: Color.purple03,
        contentColor: Color.white,
        buttonBorderColor: Color.white,
        buttonTextColor: Color.white
    )
        
    static let secondary = LocationSelectBarStyle(
        backgroundColor: Color.white,
        contentColor: Color.black,
        buttonBorderColor: Color.black,
        buttonTextColor: Color.purple03
    )
}

struct LocationSelectBar: View {
    var model: LocationSelectBarModel
    
    var body: some View {
        let style = model.style
        
        HStack{
            HStack(spacing:10){
                Image("mappin")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 18, height: 23)
                    .foregroundStyle(style.contentColor)
                Text(model.theaterLocation.rawValue)
                    .font(.pretend(type: .semibold, size: 13))
                    .foregroundStyle(style.contentColor)
            }
            
            Spacer()
            
            Button(action:model.onAction){
                Text(model.buttonText)
                    .font(.pretend(type: .semibold, size: 13))
                    .foregroundStyle(style.buttonTextColor)
            }
            .padding(5)
            .frame(width: 65, height: 36, alignment: .center)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .inset(by: 0.5)
                    .stroke(style.buttonBorderColor)
            )
        }
        .padding(.horizontal, 35)
        .padding(.vertical, 10)
        .frame(width: 440, alignment: .center)
        .background(style.backgroundColor)
    }
    
}

#Preview {
    LocationSelectBar(model: LocationSelectBarModel(
        theaterLocation: TheaterType.gangnam,
        buttonText: "극장 변경",
        onAction: {print("프리뷰에서 액션 실행")},
        style: .primary
    ))
    LocationSelectBar(model: LocationSelectBarModel(
        theaterLocation: TheaterType.gangnam,
        buttonText: "극장 변경",
        onAction: {print("프리뷰에서 액션 실행")},
        style: .secondary
    ))
}
