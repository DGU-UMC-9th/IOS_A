//
//  RainbowView.swift
//  Week3_Practice
//
//  Created by 이연우 on 10/6/25.
//

import Foundation
import SwiftUI

struct RainbowView: View {
    
    @State private var navigationTrue: Bool = false
    
    var viewModel: RainbowViewModel = .init()
    
    var body: some View {
        NavigationStack{
            VStack {
                colorCardGroup
                Spacer()
                bottomSelecteColorGroup
            }
            .safeAreaPadding(EdgeInsets(top: 50, leading: 15, bottom: 47, trailing: 15))
            .navigationDestination(isPresented: $navigationTrue, destination: {
                ColorNavigationView(viewModel: viewModel)
            })
        }
    }
    
    private func makeColorCard(_ model: RainbowModel) -> some View {
        VStack(spacing:6, content: {
            Rectangle()
                .fill(model.returnColor())
                .frame(width: 87, height: 80)
            
            Text(model.returnColorName())
                .foregroundStyle(Color.black)
                .font(.title)
        })
        .frame(maxWidth: .infinity, minHeight: 110)
    }
    
    private var bottomSelecteColorGroup: some View {
        VStack(spacing: 65, content : {
            Image(.appleLogo)
                .renderingMode(.template)
                .fixedSize()
                .foregroundStyle(viewModel.appleLogoColor ?? Color.black)
            HStack{
                Text("현재 선택된 색상: ")
                    .font(.title)
                    .foregroundStyle(Color.black)
                
                Text(selectedColorName())
                    .font(.title)
                    .foregroundStyle(Color.black)
            }
            
        })
    }
    
    
    private func selectedColorName() -> String {
        if let name = viewModel.selectedRainbowModel {
            return name.returnColorName()
        }
        else {
            return "아무것도 없음"
        }
    }
    
    private var colorCardGroup : some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing:40), count:3), //여기서의 spacing 은 열 간 간격을 의미
            spacing: 26, content:{ //여기서의 spacing 은 열 내에서 각 요소의 간격을 의미
            
            ForEach(RainbowModel.allCases, id: \.self, content: { rainbow in
                            makeColorCard(rainbow)
                                    .onTapGesture {
                                            viewModel.selectedRainbowModel = rainbow
                                        self.navigationTrue.toggle()
                                        }
                                    
                        })
        })
            
    }
    
}

#Preview {
    RainbowView()
}

