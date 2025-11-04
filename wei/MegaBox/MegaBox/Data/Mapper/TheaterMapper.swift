//
//  TheaterMapper.swift
//  MegaBox
//
//  Created by 이연우 on 11/4/25.
//

import Foundation

struct TheaterMapper {
    
    static func toDomain(from area: AreaDTO, item: AreaItemDTO) -> TheaterModel {
        return TheaterModel(
            name: item.auditorium,   
            region: area.area
        )
    }
}
