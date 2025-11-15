//
//  BookingDTO.swift
//  MegaBox
//
//  Created by 김도연 on 10/23/25.
//

import Foundation

struct BookingResponse: Codable {
    let status: String
    let message: String
    let data: DataDTO?
}

struct DataDTO: Codable {
    let movies: [MovieDTO]
}

struct MovieDTO: Codable {
    let id: String
    let title: String
    let age_rating: String
    let schedules: [ScheduleDTO]
}

struct ScheduleDTO: Codable {
    let date: String
    let areas: [AreaDTO]
}

struct AreaDTO: Codable {
    let area: String
    let items: [ItemDTO]
}

struct ItemDTO: Codable {
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

// MARK: - Mappers
struct MovieDTOMapper {
    static func toDomain(from dto: MovieDTO) -> Movie {
        return Movie(
            id: dto.id,
            title: dto.title,
            ageRating: dto.age_rating,
            schedules: toSchedules(from: dto)
        )
    }
    
    static func toSchedules(from dto: MovieDTO) -> [ScreeningSchedule] {
        return dto.schedules.flatMap { schedule in
            schedule.areas.map { area in
                ScreeningSchedule(
                    date: schedule.date,
                    branch: area.area,
                    theaters: area.items.map { item in
                        TheatersMapper.toDomain(from: item)
                    }
                )
            }
        }
    }
}

struct TheatersMapper {
    static func toDomain(from dto: ItemDTO) -> Theaters {
        return Theaters(
            theaterName: dto.auditorium,
            screenType: dto.format,
            times: dto.showtimes.map { showtime in
                ScreeningMapper.toDomain(from: showtime)
            }
        )
    }
}

struct ScreeningMapper {
    static func toDomain(from dto: ShowtimeDTO) -> Screening {
        return Screening(
            startTime: dto.start,
            endTime: dto.end,
            availableSeats: dto.available,
            totalSeats: dto.total
        )
    }
}
