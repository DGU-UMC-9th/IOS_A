//
//  UserMapper.swift
//  umc9
//
//  Created by 백지은 on 10/31/25.
//

//struct UserMapper {
//    static func toDomain(from dto: UserDTO) -> User {
//        return UserModel(
//            iid: userId,
//            name: name,
//            profileImageURL: profileImage,
//            bio: userBio
//        )
//    }
//    
//    static func toDTO(from domain: User) -> UserDTO {
//        return UserDTO(
//            userId: domain.id,
//            name: domain.name,
//            profileImageURL: domain.profileImageURL,
//            bio: domain.bio,
//            created_at: ISO8601DateFormatter().string(from: Date())
//        )
//    }
//    
//    // 복잡한 매핑 로직
//    static func toDomainList(from dtos: [UserDTO]) -> [User] {
//        return dtos.map { toDomain(from: $0) }
//    }
//}
//
//// DTO → 도메인
//let user = UserMapper.toDomain(from: userDTO)
//
//// 도메인 → DTO
//let dto = UserMapper.toDTO(from: user)
//
//// 리스트 변환
//let users = UserMapper.toDomainList(from: userDTOs)
