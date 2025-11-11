//
//  AreaItemDTO.swift
//  MegaBox
//
//  Created by 이연우 on 11/3/25.
//

import Foundation

struct AreaItemDTO : Codable {
    let auditorium : String
    let format : String
    let showtimes : [ShowtimesDTO]
}
