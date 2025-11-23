//
//  MovieModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation

struct MovieModel: Identifiable, Hashable {
    let id: UUID
    var serverId: Int? // TMDB API ID 추가
    let name: String
    let imageName: String  // 이제 URL 문자열로 사용
    let audience: String
    let age: Int
    
    // 기본 생성자
    init(id: UUID = UUID(), serverId: Int? = nil, name: String, imageName: String, audience: String, age: Int) {
        self.id = id
        self.serverId = serverId
        self.name = name
        self.imageName = imageName
        self.audience = audience
        self.age = age
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
    static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
        lhs.id == rhs.id
    }
    
}

struct MovieInfo {
    let name: String
    let englishName: String
    let description: String
    let poster: String  // 이제 URL 문자열로 사용
    let date: String
    let age: Int
}
