//
//  BookingModel.swift
//  MegaBox
//
//  Created by 김도연 on 10/12/25.
//

import Foundation
import SwiftUI

struct Movie: Identifiable {
    let id: String
    var posterImage: Image?
    var title: String
    var ageRating: String
    var schedules: [ScreeningSchedule]  // 영화별 스케줄 포함
}

struct ScreeningSchedule: Identifiable {
    let id = UUID()
    let date: String
    let branch: String
    let theaters: [Theaters]
}

struct Theaters: Identifiable {
    let id = UUID()
    let theaterName: String
    let screenType: String
    let times: [Screening]
}

struct Screening: Identifiable {
    let id = UUID()
    var startTime: String
    var endTime: String
    var availableSeats: Int
    var totalSeats: Int
}
