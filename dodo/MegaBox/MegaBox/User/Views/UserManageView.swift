//
//  UserManageView.swift
//  MegaBox
//
//  Created by 김도연 on 9/19/25.
//

import SwiftUI

struct UserManageView: View {
    @AppStorage("userId") var userId: String = ""
    @AppStorage("userName") var userName: String = ""
    @State private var newName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("기본정보")
                .font(.bold18)
            Spacer()
                .frame(height: 26)
            
            Text("\(userId)")
                .font(.medium18)
            Divider()
            Spacer()
                .frame(height: 24)
            
            HStack {
                TextField("\(userName)", text: $newName)
                    .font(.medium18)
                Spacer()
                Button {
                    userName = newName
                } label: {
                    Text("변경")
                        .font(.medium10)
                        .foregroundStyle(.gray04)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .stroke(.gray04)
                        )
                }
                .padding(.bottom, 8)
            }
            Divider()
            Spacer()
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .title) {
                Text("회원정보 관리")
                    .font(.medium16)
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserManageView()
    }
}
