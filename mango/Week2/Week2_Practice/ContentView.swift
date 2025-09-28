//
//  ContentView.swift
//  Week_Practice
//
//  Created by 송민교 on 9/24/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("username") private var username: String = "mango"
    var body: some View {
        VStack {
            Text("Hello, \(username)!")
            Button("이름 변경"){
                username = "minkyo"
            }
        }
    }
}

#Preview {
    ContentView()
}
