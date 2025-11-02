//
//  APIResponse.swift
//  Megabox
//
//  Created by 송민교 on 11/2/25.
//

import Foundation

struct APIResponse: Codable {
    let status: String
    let message: String
    let data: MovieData
}

struct MovieData: Codable{
    let movies: [MovieDTO]
}
