//
//  MovieDTO.swift
//  Megabox
//
//  Created by 송민교 on 11/2/25.
//

import Foundation

struct MovieDTO: Codable {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [ScheduleDTO]
    
    private enum CodingKeys: String, CodingKey{
        case id, title, schedules
        case ageRating = "age_rating"
    }
}

extension MovieDTO {
    func toDomain() -> MovieSelectModel {
        return MovieSelectModel(movieImageName: "placeholder", title: title, isSelected: false)
    }
    
    func toTheaterInfos() -> [TheaterInfo] {
        schedules.flatMap { scheduleDTO in
            scheduleDTO.areas.flatMap { areaDTO in
                areaDTO.items.map { itemDTO in
                    TheaterInfo(
                        theater: TheaterType(rawValue: areaDTO.area) ?? .gangnam,
                        movie: self.toDomain(),
                        theaterDetail: itemDTO.auditorium,
                        movieTime: itemDTO.showtimes.map {$0.toDomain()},
                        movieDate: scheduleDTO.date)
                }
            }
        }
    }
}
