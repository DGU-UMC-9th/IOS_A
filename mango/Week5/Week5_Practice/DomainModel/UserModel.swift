//
//  UserModel.swift
//  Week5_Practice
//
//  Created by 송민교 on 11/1/25.
//

import Foundation

struct UserModel {
    // API의 응답 구조와 무관하게 우리 모델은 "name"으로 통일 (user_name을 보내든 username을 보내든...)
    let id: String
    let name: String
    let profileImageURL: String?
    let bio: String
    
    
    // 비지니스 로직이 모델 안에 있음
    // 도메인 로직: 프로필이 완성되었는지
    var isProfileComplete: Bool{
        !name.isEmpty && !bio.isEmpty
    }
    
    // 도메인 로직: 표시용 이름 생성
    var displayName: String{
        name.isEmpty ? "익명" : name
    }
}
