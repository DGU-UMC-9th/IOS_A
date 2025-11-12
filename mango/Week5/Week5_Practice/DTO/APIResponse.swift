//
//  APIResponse.swift
//  Week5_Practice
//
//  Created by 송민교 on 11/2/25.
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
