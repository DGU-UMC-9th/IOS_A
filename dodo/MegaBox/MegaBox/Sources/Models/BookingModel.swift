//
//  BookingModel.swift
//  MegaBox
//
//  Created by 김도연 on 10/12/25.
//

import Foundation
import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    var posterImage: Image
    var title: String
    var ageRating: Int
}

//TODO: var movie: Movie 추가
struct Screening: Identifiable {
    let id = UUID()
    var startTime: String
    var endTime: String
    var availableSeats: Int
    var totalSeats: Int
}

struct Theaters: Identifiable {
    let id = UUID()
    let theaterName: String
    let screenType: String
    let times: [Screening]
}

struct ScreeningSchedule: Identifiable {
    let id = UUID()
    let branch: String
    let theaters: [Theaters]
}
