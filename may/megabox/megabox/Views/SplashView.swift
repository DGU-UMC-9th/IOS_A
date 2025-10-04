//
//  SplashView.swift
//  megabox
//
//  Created by 백지은 on 9/20/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack (alignment: .center){
            Image(.meboxLogo)
                .background(Color.white)
        }
    }
}

enum PREVIEW_DEVICE_TYPE : String, CaseIterable {
    case iPhone_15_Pro = "iPhone 16 Pro Max"
    case iPhone_11 = "iPhone 11"
    
    var previewDevice: PreviewDevice {
        .init(rawValue: self.rawValue)
    }
}

func devicePreviews<Content: View>(
    content: @escaping () -> Content
) -> some View {
    ForEach(PREVIEW_DEVICE_TYPE.allCases, id: \.self) { device in
        content()
            .previewDevice(device.previewDevice)
            .previewDisplayName(device.rawValue)
    }
}

#Preview {
    SplashView()
}
