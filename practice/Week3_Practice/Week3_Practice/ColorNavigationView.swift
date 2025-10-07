//
//  ColorNavigationView.swift
//  Week3_Practice
//
//  Created by 이연우 on 10/6/25.
//

import Foundation
import SwiftUI

struct ColorNavigationView: View {
    
    @Bindable var viewModel: RainbowViewModel
    //만약 상위뷰인 RainbowView 에서 RainbowViewModel 값을 변경했다면 하위뷰인 NavigationView 도 변경되도록!!
    //하위뷰에서 바뀌더라도 상위뷰에 반영되도록함!
    @Environment(\.dismiss) var dismiss
    //SwiftUI 환경 값에서 현재 화면을 닫는 액션을 꺼내오는 것
    
    var body: some View {
        VStack(spacing:70){
            if let selectedRainbowModel = viewModel.selectedRainbowModel{
                Text("현재 선택된 색상\n\(selectedRainbowModel.returnColorName())")
                    .font(.title)
                    .foregroundStyle(Color.black)
                
                Button(action: {
                    viewModel.appleLogoColor = selectedRainbowModel.returnColor()
                    dismiss()
                }, label:{
                    Text("사과 색 바꾸기")
                            .padding(.vertical, 43)
                            .padding(.horizontal, 36)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.clear)
                                    .stroke(Color.black, style: .init(lineWidth: 1))
                            })
                })
            }
            
        }
        .navigationTitle("색 네비")
    }
}
