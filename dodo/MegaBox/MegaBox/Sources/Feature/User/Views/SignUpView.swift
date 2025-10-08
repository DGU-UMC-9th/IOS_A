//
//  SignUpView.swift
//  MegaBox
//
//  Created by 김도연 on 10/1/25.
//

import SwiftUI

struct SignUpView: View {
    @AppStorage("userId") private var userId: String = ""
    @AppStorage("password") private var password: String = ""
    @Environment(\.dismiss) private var dismiss
    
    @State var id: String = ""
    @State var pw: String = ""
    
    var body: some View {
        VStack {
            TextField("id", text: $id)
                .textInputAutocapitalization(.never)
            Divider()
            TextField("password", text: $pw)
                .textInputAutocapitalization(.never)
            Divider()
            
            Button {
                userId = self.id
                password = self.pw
                dismiss()
            } label: {
                Text("회원가입")
            }
        }
        .padding(.horizontal)
        .navigationTitle("회원가입")
    }
}

#Preview {
    SignUpView()
}
