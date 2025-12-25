//
//  ProfileView.swift
//  Megabox
//
//  Created by 송민교 on 9/28/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage = UIImage(systemName: "person.circle.fill")!
    
    var body: some View {
        VStack(spacing:33){
            VStack(spacing:15){
                profileHeader
                
                membershipButton
            }
            
            statusInfo
            
            bottomImage
        }
        .frame(width: 380)
        .offset(y: -150) // 실제 레이아웃에는 그대로 두고 보이는 위치만 이동
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: $selectedImage)
        }
    }
    
    private var profileHeader: some View {
        @AppStorage("userName") var userName = ""
        
        return VStack{
            HStack{
                Button(action:{
                    showImagePicker = true
                }){
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .foregroundStyle(Color.gray)
                }
                
                VStack(alignment:.leading){
                    HStack{
                        Text("\(userName)님")
                            .font(.pretend(type: .bold, size: 24))
                        Text("WELCOME")
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(red: 0.28,green:0.8,blue:0.82))
                            .cornerRadius(6)
                    }
                    HStack{
                        Text("멤버십 포인트")
                            .foregroundStyle(Color.gray04)
                            .font(.pretend(type: .semibold, size: 14))
                        Text("500P")
                            .font(.pretend(type: .medium, size: 14))
                    }
                }
                
                Spacer()
                
                Button(action:{}){
                    Text("회원정보")
                        .foregroundStyle(Color.white)
                        .font(.pretend(type: .semibold, size: 14))
                }
                .padding(8)
                .background(Color.gray07)
                .cornerRadius(16)
                .frame(width: 72)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var membershipButton:some View{
        Button(action:{}){
            Text("클럽 멤버십")
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 8)
        .padding(.vertical, 12)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.67, green:0.55, blue:1),
                    Color(red: 0.56, green: 0.68, blue: 0.95),
                    Color(red: 0.36, green: 0.8, blue: 0.93)
                ], startPoint: UnitPoint(x:0, y:0.5), endPoint: UnitPoint(x:1, y:0.5))
            
        )
        .cornerRadius(8)
    }
    
    private var statusInfo: some View{
        HStack(spacing:33){
            VStack(spacing:9){
                Text("쿠폰")
                    .foregroundStyle(Color.gray02)
                    .font(.pretend(type: .semibold, size: 16))
                Text("2")
                    .font(.pretend(type: .semibold, size: 18))
            }
            
            Rectangle()
                .frame(width:1, height:31)
                .foregroundStyle(.clear)
                .background(Color.gray02)
            
            VStack(spacing:9){
                Text("스토어 교환권")
                    .foregroundStyle(Color.gray02)
                    .font(.pretend(type: .semibold, size: 16))
                    .frame(width: 87)
                Text("0")
                    .font(.pretend(type: .semibold, size: 18))
            }
            
            Rectangle()
                .frame(width:1, height:31)
                .foregroundStyle(.clear)
                .background(Color.gray02)
            
            VStack(spacing:9){
                Text("모바일 티켓")
                    .foregroundStyle(Color.gray02)
                    .font(.pretend(type: .semibold, size: 16))
                    .frame(width: 73)
                Text("0")
                    .font(.pretend(type: .semibold, size: 18))
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
    }
    
    private var bottomImage: some View{
        HStack(){
            VStack(spacing:12){
                Image("icon1")
                    .resizable()
                    .frame(width: 36, height: 36)
                Text("영화별예매")
                    .font(.pretend(type: .medium, size: 16))
            }
            Spacer()
            VStack(spacing:12){
                Image("icon2")
                    .resizable()
                    .frame(width: 36, height: 36)
                Text("극장별예매")
                    .font(.pretend(type: .medium, size: 16))
            }
            Spacer()
            VStack(spacing:12){
                Image("icon3")
                    .resizable()
                    .frame(width: 36, height: 36)
                Text("특별관예매")
                    .font(.pretend(type: .medium, size: 16))
            }
            Spacer()
            VStack(spacing:12){
                Image("icon4")
                    .resizable()
                    .frame(width: 36, height: 36)
                Text("모바일오더")
                    .font(.pretend(type: .medium, size: 16))
            }
        }
    }
}

#Preview {
    ProfileView()
}
