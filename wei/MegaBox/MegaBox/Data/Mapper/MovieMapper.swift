import Foundation

struct MovieMapper {
    static func toDomain(from dto: MovieDTO) -> MovieModel {
        return MovieModel(
            serverId: dto.id,
            name: dto.title,
            imageName: dto.title,  // 실제 이미지 매핑 필요 시 수정
            audience: "미집계",
            age: Int(dto.age_rating) ?? 0 
        )
    }
}
