//
//  DTOMapper.swift
//  megabox
//
//  Created by 백지은 on 11/2/25.
//

import Foundation
import SwiftUI

// MARK: - MovieDTO → MovieBooking
extension MovieDTO {
    func toDomain() -> MovieBooking {
        return MovieBooking(
            id: id,
            posterImage: Self.addPosterImg(for: id),
            title: title,
            ageRating: age_rating
        )
    }
    
    private static func addPosterImg(for id: String) -> Image {
        switch id {
        case "m-001": return Image("movie1")
        case "m-002": return Image("movie2")
        case "m-003": return Image("movie3")
        case "m-004": return Image("movie4")
        case "m-005": return Image("movie5")
        case "m-006": return Image("movie6")
        default: return Image("movie1")
        }
    }
}

// MARK: - ScheduleDTO → [ScreeningSchedule]
extension ScheduleDTO {
    func toDomain() -> [ScreeningSchedule] {
        return areas.flatMap { $0.toDomain() }
    }
}

// MARK: - AreaDTO → [ScreeningSchedule]
extension AreaDTO {
    func toDomain() -> [ScreeningSchedule] {
        return items.map { $0.toDomain(area: area) }
    }
}

// MARK: - ItemDTO → ScreeningSchedule
extension ItemDTO {
    func toDomain(area: String) -> ScreeningSchedule {
        let times = showtimes.map { $0.toDomain() }
        return ScreeningSchedule(
            theaterName: auditorium,
            screenType: format,
            times: times
        )
    }
}

// MARK: - ShowtimeDTO → ScreeningTime
extension ShowtimeDTO {
    func toDomain() -> ScreeningTime {
        return ScreeningTime(
            startTime: start,
            endTime: end,
            availableSeats: available,
            totalSeats: total
        )
    }
}
