//
//  OrderButton.swift
//  Megabox
//
//  Created by 송민교 on 11/22/25.
//
import SwiftUI

struct OrderButtonModel{
    let title: String
    let description: String?
    let iconName: String
    let action: ()->Void
}

struct OrderButton: View {
    let model: OrderButtonModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action:{
                model.action()
            }){
                VStack(spacing: 15){
                    VStack(alignment: .leading, spacing: 8) {
                        Text(model.title)
                            .font(.pretend(type: .bold, size: 24))
                        if let description = model.description {
                            Text(description)
                                .font(.pretend(type: .light, size: 12))
                                .foregroundStyle(.gray06)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Image(systemName: model.iconName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
                    .frame(maxWidth:.infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
            }
            .foregroundStyle(.black)
            .padding(15)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 1)
        }
    }
}
