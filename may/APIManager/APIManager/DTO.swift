//
//  DTO.swift
//  APIManager
//
//  Created by 백지은 on 11/16/25.
//

import Foundation

struct UserInfo: Codable {
    var accessToken: String?
    var refreshToken: String?
}

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    let expiresIn: Int
}

struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct RefreshTokenRequest: Codable {
    let refreshToken: String
}

struct UserData: Codable {
    let id: Int?
    let name: String
    let age: Int
    let address: String
    let height: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, age, address, height
    }
    
    init(id: Int? = nil, name: String, age: Int, address: String, height: Double) {
        self.id = id
        self.name = name
        self.age = age
        self.address = address
        self.height = height
    }
}

struct UserPatchRequest: Codable {
    let name: String?
    let age: Int?
    let address: String?
    let height: Double?
}
