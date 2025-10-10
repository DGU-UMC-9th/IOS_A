//
//  MegaboxApp.swift
//  Megabox
//
//  Created by 송민교 on 9/19/25.
//

import SwiftUI

@main
struct MegaboxApp: App {
    @State private var router = NavigationRouterViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(router)
        }
    }
}
