//
//  APIResponse.swift
//  umc9
//
//  Created by 백지은 on 10/31/25.
//

import Foundation

struct APIResponse: Codable {
    let status: String
    let message: String
    let data: UserData
}

struct UserData: Codable {
    let users: [UserDTO]
}
