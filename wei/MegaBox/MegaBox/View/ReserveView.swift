//
//  ReserveView.swift
//  MegaBox
//
//  Created by 이연우 on 10/12/25.
//

import Foundation
import SwiftUI

struct ReserveView: View {
    
    var movieViewModel : MovieInfoViewModel = .init()
    
    var body: some View {
        Text("ReserveView")
    }
    
    private var Navigation : some View {
        VStack {
            Spacer()
            Text("영화별 예매")
                .font(.bold22)
                .foregroundStyle(Color.white)
        }
        .padding(.bottom,10)
        .background(Color.purple03)
    }
    
    private var MovieSelection : some View {
        VStack {
            HStack{
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(Color.orange)
                    .overlay(
                        Text(movieViewModel.age)
                            .font(.bold18)
                            .foregroundStyle(Color.white)
                    )
            }
        }
    }
    
    
}
