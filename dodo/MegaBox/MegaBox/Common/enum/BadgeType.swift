//
//  BadgeType.swift
//  MegaBox
//
//  Created by 김도연 on 11/19/25.
//

import SwiftUI

enum BadgeType {
    case best
    case recommend
    
    var title: String {
        switch self {
        case .best: return "BEST"
        case .recommend: return "추천"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .best: return .red
        case .recommend: return .blue
        }
    }
}
