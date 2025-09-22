//
//  SplashView.swift
//  Week1
//
//  Created by 이연우 on 9/22/25.
//

import Foundation
import SwiftUI

enum PREVIEW_DEVICE_TYPE : String, CaseIterable {
    case iPhone_16_Pro = "iPhone 16 Pro"
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



struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center){
            Color.white
            Image(.meboxLogo1)
//                .frame(width: 249, height: 84)
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

