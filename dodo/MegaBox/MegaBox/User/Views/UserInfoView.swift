//
//  UserInfoView.swift
//  MegaBox
//
//  Created by 김도연 on 9/19/25.
//

import SwiftUI

struct UserInfoView: View {
    @AppStorage("userName") private var userName: String = "사용자"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 33) {
                userInfo
                status
                buttomImages
                Spacer()
            }
            .padding()
        }
    }
    
    var userInfo: some View {
        VStack {
            HStack {
                Text("\(userName)님")
                    .font(.bold24)
                Text("WELCOME")
                    .font(.medium14)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(Color(red: 0.28, green: 0.8, blue: 0.82))
                    )
                Spacer()
                NavigationLink {
                    UserManageView()
                } label: {
                    Text("회원정보")
                        .font(.medium14)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6)
                        .padding(4)
                        .background(
                            Capsule()
                                .foregroundStyle(Color(red: 0.28, green: 0.28, blue: 0.28))
                        )
                }
            }
            HStack(spacing: 9) {
                Text("멤버십 포인트")
                    .font(.semiBold14)
                    .foregroundStyle(.gray04)
                Text("500P")
                    .font(.medium14)
                Spacer()
            }
            
            NavigationLink {
                
            } label: {
                HStack(spacing: 3) {
                    Text("클럽 멤버십")
                        .font(.semiBold16)
                        .foregroundStyle(.white)
                    Image(systemName: "chevron.right")
                        .tint(.white)
                    Spacer()
                }
                .padding()
                .background(
                    LinearGradient(
                    stops: [
                    Gradient.Stop(color: Color(red: 0.67, green: 0.55, blue: 1), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.56, green: 0.68, blue: 0.95), location: 0.53),
                    Gradient.Stop(color: Color(red: 0.36, green: 0.8, blue: 0.93), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0, y: 0.5),
                    endPoint: UnitPoint(x: 1, y: 0.5)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                )
            }
            .padding(.top, 12)
        }
    }
    
    var status: some View {
        HStack(alignment: .center, spacing: 32) {
            VStack(spacing: 8) {
                Text("쿠폰")
                    .font(.semiBold16)
                    .foregroundStyle(.gray02)
                Text("2")
                    .font(.semiBold18)
            }
            Divider()
                .frame(height: 32)
            VStack(spacing: 8) {
                Text("스토어 교환권")
                    .font(.semiBold16)
                    .foregroundStyle(.gray02)
                Text("0")
                    .font(.semiBold18)
            }
            Divider()
                .frame(height: 32)
            VStack(spacing: 8) {
                Text("모바일 티켓")
                    .font(.semiBold16)
                    .foregroundStyle(.gray02)
                Text("0")
                    .font(.semiBold18)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 0.5)
                .stroke(.gray02)
            
        )
    }
    
    var buttomImages: some View {
        HStack(spacing: 28) {
            ForEach(BookingType.allCases, id: \.self) { bookingType in
                NavigationLink {
                    
                } label: {
                    VStack {
                        Image(bookingType.iconName)
                        Text(bookingType.description)
                            .font(.medium16)
                    }
                }
                .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    UserInfoView()
}
