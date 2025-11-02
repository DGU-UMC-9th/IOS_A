//
//  CommentDTO.swift
//  Week5_Practice
//
//  Created by 송민교 on 11/2/25.
//

import Foundation

struct CommentDTO: Codable {
    let comment_id: String
    let text: String
    let user: UserDTO
    let timestamp: String
}

struct CommentMapper {
    static func toDomain(from dto: CommentDTO) -> CommentModel {
        let dateFormatter = ISO8601DateFormatter()
        let createdAt = dateFormatter.date(from: dto.timestamp) ?? Date()
        
        return CommentModel(
            id: dto.comment_id,
            content: dto.text,
            author: dto.user.toDomain(),
            createdAt: createdAt
        )
    }
}
