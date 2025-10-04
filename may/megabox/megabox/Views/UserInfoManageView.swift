//
//  UserInfoManageView.swift
//  megabox
//
//  Created by 백지은 on 9/28/25.
//

import SwiftUI

struct UserInfoManageView: View {
    @AppStorage("id") var id: String = ""
    @AppStorage("username") var username: String = ""
    @State private var newName: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            headerSection
            contentSection
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var headerSection: some View {
        ZStack {
            Text("회원정보 관리")
                .font(.medium16)
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left.square")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 26, height: 26)
                }
                Spacer() // 버튼 오른쪽 공간
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 53)
    }
    
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 26){
            Text("기본 정보")
                .font(.bold18)
            VStack(alignment: .leading){
                Text("\(id)")
                Divider()
                Spacer()
                    .frame(height: 24)
                HStack{
                    TextField("\(username)", text: $newName)
                                        .font(.medium18)
                                        .foregroundStyle(.black)
                    Spacer()
                    Button{
                        username = newName
                    } label: {
                        Text("변경")
                            .font(.medium10)
                            .foregroundStyle(.gray03)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .stroke(.gray04)
                            )
                    }
                }
                .frame(width: .infinity, height: 21)
                Divider()
            }
        }
        .padding(.horizontal, 16)
//        .padding(.bottom, 580)
    }
    
}

#Preview {
    NavigationStack {
        UserInfoManageView()
    }
}
