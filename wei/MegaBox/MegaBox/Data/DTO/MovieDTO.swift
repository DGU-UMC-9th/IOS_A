//
//  MovieDTO.swift
//  MegaBox
//
//  Created by 이연우 on 11/3/25.
//

import Foundation

struct MovieDTO : Codable {
    let id : String
    let title : String
    let age_rating : String
    let schedules : [ScheduleDTO]
}
