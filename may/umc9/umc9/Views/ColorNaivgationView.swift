//
//  ColorNaivgationView.swift
//  umc9
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI
import Observation

struct ColorNavigationView: View {
    
    @Bindable var viewModel: RainbowViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 70) {
            if let selectedRainbowModel = viewModel.selectedRainbowModel {
                Text("현재 선택된 색상 : \(selectedRainbowModel.returnColorName())")
                    .font(.bold22)
                    .foregroundStyle(Color.black)
                
                Button(action: {
                    viewModel.appleLogoColor = selectedRainbowModel.returnColor()
                    dismiss()
                }, label: {
                    Text("사과 색 바꾸기")
                        .font(.bold18)
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selectedRainbowModel.returnColor())
                                .stroke(Color.gray, style: .init(lineWidth: 1))
                            //선택된 색깔로 버튼 만들고 싶어서 바꿈
                        }
                })
            }
        }
        .navigationTitle("색 네비")
    }
}
