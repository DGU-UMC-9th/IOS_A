//
//  ContentView.swift
//  MoyaTest
//
//  Created by 백지은 on 11/16/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(ButtonInfoList.buttonList, id: \.id) { button in
                Button(action: {
                    button.action()
                }, label: {
                    Text(button.title)
                })
            }
        }
        .padding()
    }
}

struct ButtonInfo: Identifiable {
    var id: UUID = .init()
    var title: String
    var action: () -> Void
}

final class ButtonInfoList {
    
    static let serviceManager: ContentViewModel = .init()
    
    static let buttonList: [ButtonInfo] = [
        
        // POST /api/auth/login
        .init(title: "로그인", action: {
            Task {
                await serviceManager.login(username: "백지은", password: "password123")
            }
        }),
        
        // GET /api/user/my
        .init(title: "My Info 조회", action: {
            Task {
                await serviceManager.getMyInfo()
            }
        }),
        
        // POST /api/auth/logout
        .init(title: "로그아웃", action: {
            Task {
                await serviceManager.logout()
            }
        }),
        
        // GET /api/user?name=
        .init(title: "GET", action: {
            Task {
                await serviceManager.getUser(name: "Hello")
            }
        }),
        
        // POST /api/user
        .init(title: "POST", action: {
            serviceManager.createUser(
                .init(name: "umc", age: 9, address: "서울", height: 9)
            )
        }),
        
        // PATCH /api/user/{userId}
        .init(title: "PATCH", action: {
            serviceManager.updateUserPatch(
                userId: 7,
                patchData: .init(name: nil, age: 23, address: nil, height: nil)
            )
        }),
        
        // PUT /api/user/{userId}
        .init(title: "PUT", action: {
            serviceManager.updateUserPut(
                userId: 7,
                userData: .init(name: "테스트사용자", age: 20, address: "서울시", height: 170)
            )
        }),
        
        // DELETE /api/user/{userId}
        .init(title: "DELETE", action: {
            serviceManager.deleteUser(userId: 8)
        }),
    ]
}

#Preview {
    ContentView()
}
