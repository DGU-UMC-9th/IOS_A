//
//  ProvileDetailView.swift
//  Megabox
//
//  Created by 송민교 on 9/28/25.
//

import SwiftUI

struct ProfileDetailView: View {
    var body: some View {
        VStack{
            navigationBar()
            userInfo()
            Spacer()
        }
    }
    
    private struct navigationBar: View{
        var body: some View{
            HStack{
                Button(action:{}){
                    Image(systemName: "arrow.left")
                        .foregroundStyle(Color.black)
                }
                Spacer()
                Text("회원정보 관리")
                    .font(.pretend(type: .medium, size: 16))
                Spacer()
            }
            .frame(height: 44)
            .padding()
        }
    }
    
    private struct userInfo: View{
        @AppStorage("id") private var id: String = ""
        @AppStorage("userName") private var userName: String = ""
        @State var changedName: String = ""
        
        var body: some View{
            VStack(spacing:26){
                Text("기본정보")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.pretend(type: .bold, size: 18))
                
                // id + 이름 View
                VStack{
                    Text("\(id)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.pretend(type: .medium, size: 18))
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray02)
                    
                    Spacer().frame(height: 20)
                    
                    HStack{
                        TextField("\(userName)", text:$changedName)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.pretend(type: .medium, size: 18))
                        Button(action:{
                            userName = changedName
                        }){
                            Text("변경")
                                .font(.pretend(type: .medium, size: 10))
                                .foregroundStyle(Color.gray03)
                                .frame(width: 38, height: 20)
                        }
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray03, lineWidth:1)
                        )
                    }
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray02)
                }
            }
            .padding()
        }
    }
}

#Preview{
    ProfileDetailView()
}
