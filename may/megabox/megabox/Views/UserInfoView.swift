//
//  UserInfoView.swift
//  megabox
//
//  Created by 백지은 on 9/28/25.
//

import SwiftUI

struct UserInfoView: View {
    @AppStorage("username") private var username: String = "사용자"
    @EnvironmentObject var model: LoginViewModel
    
    var body: some View {
        VStack{
            headerSection
            membershipSection
            couponSection
            buttonSection
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    private var headerSection: some View {
        VStack{
            HStack{
                Text("\(username)님")
                    .font(.bold24)
                Text("WELCOME")
                    .font(.medium14)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.mint01)
                        )
                Spacer()
                NavigationLink {
                    UserInfoManageView()
                        .environmentObject(model)
                    } label: {
                    Text("회원정보")
                        .font(.semiBold14)
                        .foregroundColor(.white)
                        .padding(.all, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width:72, height: 28)
                                .foregroundStyle(Color.gray07)
                                .cornerRadius(16)
                    )}
                    .padding(.all, 4)
            }
            HStack{
                Text("멤버십 포인트")
                    .font(.semiBold14)
                    .foregroundColor(.gray04)
                    .padding(.trailing, 9)
                Text("500P")
                    .font(.medium14)
                    .foregroundColor(.black)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 3)
        .padding(.top, 35)
    }
    
    private var membershipSection: some View {
        Button{
            
        } label: {
            HStack(spacing: 3) {
                Text("클럽 멤버십")
                    .font(.semiBold16)
                    .foregroundStyle(.white)
                Image(systemName: "chevron.right")
                    .tint(.white)
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            .frame(height: 46)
            .background(LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.67, green: 0.55, blue: 1), location: 0.0),
                    Gradient.Stop(color: Color(red: 0.56, green: 0.68, blue: 0.95), location: 0.5337),
                    Gradient.Stop(color: Color(red: 0.36, green: 0.8, blue: 0.93), location: 1.0),
                    ],
                startPoint: .leading,
                endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 14)
        }
    }
    
    private var couponSection: some View {
        HStack(alignment: .center){
            VStack(spacing: 9) {
                Text("쿠폰")
                    .font(.semiBold16)
                    .foregroundStyle(.gray02)
                Text("500P")
                    .font(.semiBold18)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .frame(height: 32)
            
            VStack(spacing: 9) {
                Text("스토어 교환권")
                    .font(.semiBold16)
                    .foregroundStyle(.gray02)
                Text("0")
                    .font(.semiBold18)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .frame(height: 32)
            
            VStack(spacing: 9) {
                Text("모바일티켓")
                    .font(.semiBold16)
                    .foregroundStyle(.gray02)
                Text("0")
                    .font(.semiBold18)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 52)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0.5)
        )
        .padding(.horizontal, 14)
        .padding(.top, 21)
    }

    private var buttonSection: some View {
        
        HStack(alignment: .center, spacing: 30){
            NavigationLink {
                
            } label: {
                VStack(spacing:12){
                    Image(.movie)
                    Text("영화별예매")
                        .font(.medium16)
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity)
            }
            NavigationLink {
                
            } label: {
                VStack(spacing:12){
                    Image(.pin)
                    Text("극장별예매")
                        .font(.medium16)
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity)
            }
            NavigationLink {
                
            } label: {
                VStack(spacing:12){
                    Image(.chair)
                    Text("특별관예매")
                        .font(.medium16)
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity)
            }
            NavigationLink {
                
            } label: {
                VStack(spacing:12){
                    Image(.popcorn)
                    Text("모바일오더")
                        .font(.medium16)
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 21)
    }
}

#Preview {
    NavigationStack {
        UserInfoView()
            .environmentObject(LoginViewModel())
    }
}
