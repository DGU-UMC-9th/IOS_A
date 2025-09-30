//
//  InfoManage.swift
//  MegaBox
//
//  Created by 이연우 on 9/29/25.
//

import Foundation
import SwiftUI
import Observation

struct InfoManageView: View {
    
    @AppStorage("id") private var userID: String = "Guest"
    @AppStorage("name") private var name: String = "이연우"
    
    
    @State private var nameInput: String = ""
    
    
    var body: some View {
        VStack(spacing:56){
            Navbar
            ContentView
        }
        .padding(.bottom, 500)
        
        
    }
    
    private var Navbar : some View {
        HStack {
            Button(action:{
                
            }, label:{
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 17, height: 17)
                    .foregroundColor(.black)
            })
            
            Spacer()
            
            Text("회원정보 관리")
                .font(.medium16)
                .foregroundStyle(Color.black)
        }
        .padding(.trailing, 166)
        .padding(.leading,16)
    }
    
    private var ContentView : some View {
        
        VStack(alignment: .leading, spacing: 24){
            
            Text("기본정보")
                .font(.bold18)
                .foregroundStyle(Color.black)
            
            VStack(alignment: .leading, spacing: 8){
                Text("\(userID)")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
                    .autocapitalization(.none)
                    
                Divider()
                    .foregroundColor(.gray02)
            }
                
            VStack{
                HStack{
                    TextField("", text: $nameInput, prompt: Text(name).foregroundColor(.black))
                                .font(.medium16)
                                .foregroundStyle(Color.black)
                                .autocapitalization(.none)
                    
                    Spacer()
                    
                    Button(action:{
                        self.name = nameInput
                    },label:{
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.clear)
                            .stroke(Color.gray03, lineWidth: 1)
                            .frame(width:40,height: 20)
                            .overlay(
                                Text("변경")
                                    .font(.medium10)
                                    .foregroundStyle(Color.gray03)
                            )
                    })
                           
                }
                
                Divider()
                    .foregroundColor(.gray02)
            }
            
        }
        .padding(.horizontal,16)
        
    }
    
}

#Preview {
    InfoManageView()
}

