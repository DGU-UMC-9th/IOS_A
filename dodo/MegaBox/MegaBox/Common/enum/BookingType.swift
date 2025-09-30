//
//  BookingType.swift
//  MegaBox
//
//  Created by 김도연 on 9/19/25.
//

import Foundation

enum BookingType: String, CaseIterable {
    case movieReservation = "영화별예매"
    case theaterReservation = "극장별예매"
    case specialReservation = "특별관예매"
    case mobileOrder = "모바일오더"
    
    var iconName: String {
        switch self {
        case .movieReservation:
            return "cinema"
        case .theaterReservation:
            return "ping"
        case .specialReservation:
            return "chair"
        case .mobileOrder:
            return "popcorn"
        }
    }
    
    var description: String {
        return self.rawValue
    }
}
