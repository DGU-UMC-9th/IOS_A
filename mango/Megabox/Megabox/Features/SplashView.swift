//
//  SplashView.swift
//  Megabox
//
//  Created by 송민교 on 9/19/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            // 다크모드에서도 배경 흰색
            Color.white.ignoresSafeArea()
            
            Image("meboxLogo1")
                .resizable()
                .scaledToFit()
                .frame(width: 249, height: 84)
        }
    }
}

struct SplashView_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            SplashView()
        }
    }
}
