//  Info.swift
//  MegaBox
//
//  Created by 이연우 on 9/29/25.
//

import Foundation
import SwiftUI
import Observation

struct InfoView: View {
    
//    @AppStorage("id") private var userID: String = "Guest"
//    @AppStorage("name") private var name: String = "이연우"
    @State var viewModel: LoginViewModel
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing:33){
            MemberContent
            StateContent
            BottomContent
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 400 )
        .navigationDestination(for: String.self)  { value in
            InfoManageView()
        }
    }
    
    private var Member : some View {
        HStack{
            MemberName
            
            Spacer()
            
            Button(
                action:{
                    path.append("detail")
                    //NavigationLink(destination:InfoManageView())
                }, label:{
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray07)
                        .frame(width: 72)
                        .overlay(
                            Text("회원정보")
                                .font(.semiBold14)
                                .foregroundStyle(Color.white)
                        )
                })
        }
        .frame(height:30)
    }
    
    
    private var MemberName : some View {
        
        HStack(spacing:5){
            Text("\(maskedName)님")
                .font(.bold24)
                .foregroundStyle(Color.black)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(.tag)
                .overlay(
                    Text("WELCOME")
                        .font(.medium14)
                        .foregroundStyle(Color.white)
                        
                )
                .frame(width: 85, height: 25)
        }
        
    }
    private var loginTagText: String {
           switch viewModel.loginType {
           case .kakao:
               return "KAKAO"
           case .normal:
               return "WELCOME"
           case .none:
               return "GUEST"
           }
       }
    
    private var maskedName: String {
        let name = viewModel.name.isEmpty ? "Guest" : viewModel.name
            
            guard name.count > 1 else {
                return name
            }
            
            
            let first = String(name.prefix(1))
            let last = String(name.suffix(1))
            
            let middleCount = name.count - 2
            
            if middleCount <= 0 {
                return first + "*"
            }
            
            let asterisks = String(repeating: "*", count: middleCount)
            
            return first + asterisks + last
        }
    
    
    private var TopMember : some View {
        VStack{
            Member
            
            HStack(spacing:9){
                Text("멤버십 포인트")
                    .font(.semiBold14)
                    .foregroundStyle(Color.gray04)
                
                Text("500P")
                    .font(.medium14)
                    .foregroundStyle(Color.black)
            }
            .padding(.trailing, 240)
        }
    }
    
    private var MemberContent : some View {
        
        VStack(spacing:15){
            TopMember
            
            Button(action:{
                
            }, label:{
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                            stops: [
                            Gradient.Stop(color: Color(red: 0.67, green: 0.55, blue: 1), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.56, green: 0.68, blue: 0.95), location: 0.53),
                            Gradient.Stop(color: Color(red: 0.36, green: 0.8, blue: 0.93), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0, y: 0.5),
                            endPoint: UnitPoint(x: 1, y: 0.5)
                            )
                        )
                    HStack{
                        Text("클럽 멤버십")
                            .font(.semiBold12)
                            .foregroundStyle(Color.white)
                        
                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .foregroundStyle(Color.white)
                                            .frame(width: 5, height: 10)
                    }
                    .padding(.trailing,240)
                    
                }
            })
        }.frame(height:116)
    }
    
    private var StateContent : some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.clear)
                .stroke(Color.gray02, lineWidth: 1)
                .frame(height: 70)
            
            HStack(spacing:30) {
                VStack(spacing:9){
                    Text("쿠폰")
                        .font(.semiBold16)
                        .foregroundStyle(Color.gray02)
                    Text("2")
                        .font(.semiBold18)
                        .foregroundStyle(Color.black)
                }
                
                Rectangle()
                    .fill(Color.gray02)
                    .frame(width: 1, height: 31)
                
                VStack(spacing:9){
                    Text("스토어교환권")
                        .font(.semiBold16)
                        .foregroundStyle(Color.gray02)
                    Text("0")
                        .font(.semiBold18)
                        .foregroundStyle(Color.black)
                }
                
                Rectangle()
                    .fill(Color.gray02)
                    .frame(width: 1, height: 31)
                
                VStack(spacing:9){
                    Text("모바일 티켓")
                        .font(.semiBold16)
                        .foregroundStyle(Color.gray02)
                    Text("0")
                        .font(.semiBold18)
                        .foregroundStyle(Color.black)
                }
                
            }
            .padding(.horizontal,24)
            .padding(.vertical,12)
        }
        
        
    }
    
    private var BottomContent : some View {
        HStack{
            VStack{
                Image(.flim)
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("영화별예매")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
            }
            
            Spacer()
            
            VStack{
                Image(.pinmap)
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("극장별예매")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
            }
            
            Spacer()
            
            VStack{
                Image(.sofa)
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("특별관예매")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
            }
            
            Spacer()
            
            VStack{
                Image(.popcorn)
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("모바일오더")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
            }
            
        }
    }
    
    
    
    
}

//#Preview {
//    InfoView()
//}
