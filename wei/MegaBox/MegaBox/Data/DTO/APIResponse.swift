//
//  APIResponse.swift
//  MegaBox
//
//  Created by 이연우 on 11/3/25.
//

import Foundation

struct APIResponse: Codable {
    let status : String
    let message : String
    let data : ShowtimesDataDTO
}
