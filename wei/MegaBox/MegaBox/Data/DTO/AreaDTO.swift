//
//  AreaDTO.swift
//  MegaBox
//
//  Created by 이연우 on 11/3/25.
//

import Foundation

struct AreaDTO : Codable {
    let area : String
    let items : [AreaItemDTO]
}
