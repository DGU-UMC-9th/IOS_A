//
//  TheaterBar.swift
//  megabox
//
//  Created by 백지은 on 11/22/25.
//

import SwiftUI

struct TheaterBar: View {
    var theaterName: String
    var onChange: () -> Void
    
    var body: some View {
        HStack {
            Image(.location)
                .renderingMode(.template)
                .foregroundStyle(.primary)
            
            Text(theaterName)
                .font(.semiBold13)
            
            Spacer()
            
            Button { onChange() } label: {
                Text("극장 변경")
                    .font(.semiBold13)
                    .frame(width: 65, height: 36)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.primary)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct OrderViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.purple03)
            .foregroundStyle(.white)
    }
}

struct DetailViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .foregroundStyle(.black)
    }
}


#Preview {
    TheaterBar(theaterName: "강남", onChange: {})
        .modifier(OrderViewStyle())
    
    TheaterBar(theaterName: "강남", onChange: {})
        .modifier(DetailViewStyle())
}
