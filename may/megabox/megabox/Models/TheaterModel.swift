//
//  TheaterModel.swift
//  megabox
//
//  Created by 백지은 on 10/11/25.
//

import Foundation

enum Theater: String, CaseIterable {
    case Gangnam = "강남"
    case Hongdae = "홍대"
    case Sinchon = "신촌"
    
    var title: String {
        return self.rawValue
    }
}

struct ScreeningSchedule: Identifiable {
    let id = UUID()
    let theaterName: String
    let screenType: String
    let times: [ScreeningTime]
}

struct ScreeningTime: Identifiable {
    let id = UUID()
    let startTime: String
    let endTime: String
    let availableSeats: Int
    let totalSeats: Int
}
