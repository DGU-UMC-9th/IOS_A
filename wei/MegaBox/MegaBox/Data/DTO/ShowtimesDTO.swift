//
//  showtimesDTO.swift
//  MegaBox
//
//  Created by 이연우 on 11/3/25.
//

import Foundation

struct ShowtimesDTO : Codable {
    let start : String
    let end : String
    let available : Int
    let total : Int
}
