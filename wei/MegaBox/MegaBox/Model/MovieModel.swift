//
//  MovieModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation

struct MovieModel: Identifiable, Hashable {
    let id: UUID  // ✅ = UUID() 제거 (init에서 처리)
    var serverId: String?
    var name: String
    var imageName: String
    var audience: String?
    var age: Int
    
    // ✅ 명시적 init 추가
    init(
        id: UUID = UUID(),
        serverId: String? = nil,
        name: String,
        imageName: String,
        audience: String?,
        age: Int
    ) {
        self.id = id
        self.serverId = serverId
        self.name = name
        self.imageName = imageName
        self.audience = audience
        self.age = age
    }
}
