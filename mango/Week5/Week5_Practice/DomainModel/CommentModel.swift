//
//  CommentModel.swift
//  Week5_Practice
//
//  Created by 송민교 on 11/1/25.
//

import Foundation

struct CommentModel {
    let id: String
    let content: String
    let author: UserModel
    let createdAt: Date
    
    // 도메인 로직: 댓글이 수정 가능한지 확인(작성 후 5분이내)
    var isEditable: Bool{
        let fiveMinutesAgo = Date().addingTimeInterval(-300)
        return createdAt > fiveMinutesAgo
    }
}
