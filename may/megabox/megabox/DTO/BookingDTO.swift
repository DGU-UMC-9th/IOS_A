//
//  BookingDTO.swift
//  megabox
//
//  Created by 백지은 on 11/2/25.
//

import Foundation

struct ApiResponse : Codable{
    let status : String
    let message : String
    let data : DataDTO?
}

struct DataDTO : Codable{
    let movies : [MovieDTO]
}

struct MovieDTO : Codable{
    let id : String
    let title : String
    let age_rating : String
    let schedules : [ScheduleDTO]
}

struct ScheduleDTO : Codable{
    let date : Date
    let areas : [AreaDTO]
}

struct AreaDTO : Codable{
    let area : String
    let items : [ItemDTO]
}

struct ItemDTO : Codable{
    let auditorium : String
    let format : String
    let showtimes : [ShowtimeDTO]
}

struct ShowtimeDTO : Codable{
    let start : String
    let end : String
    let available : Int
    let total : Int
}

// MARK: - JSONDecoder Extension
extension JSONDecoder {
    static var movieScheduleDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        
        // 날짜 포맷
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") //??
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
}
