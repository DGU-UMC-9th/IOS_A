//
//  ScheduleDTO.swift
//  Megabox
//
//  Created by 송민교 on 11/2/25.
//

import Foundation

struct ScheduleDTO: Codable {
    let date: String
    let areas: [ScheduleAreaDTO]
}

struct ScheduleAreaDTO: Codable {
    let area: String
    let items: [ScheduleItemDTO]
}

struct ScheduleItemDTO: Codable {
    let auditorium: String
    let format: String
    let showtimes: [ShowtimeDTO]
}


struct ShowtimeDTO: Codable {
    let start: String
    let end: String
    let available: Int
    let total: Int
    
}
extension ShowtimeDTO{
    func toDomain() -> MovieTime{
        MovieTime(startTime: start, endTime: end, leftSeats: available, totalSeats: total)
    }
}
