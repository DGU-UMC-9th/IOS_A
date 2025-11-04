//
//  ScheduleDTO.swift
//  MegaBox
//
//  Created by 이연우 on 11/3/25.
//

import Foundation

struct ScheduleDTO : Codable {
    let date : String
    let areas: [AreaDTO]
}
