//
//  TMDBDTO.swift
//  MegaBox
//
//  Created by 김도연 on 11/15/25.
//

import Foundation

struct TMDBResponse: Codable {
    let dates: TMDBDates
    let page: Int
    let results: [TMDBMovie]
}

struct TMDBDates: Codable {
    let maximum: String
    let minimum: String
}

struct TMDBMovie: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

//MARK: - Mappers
struct MovieModelMapper {
    private static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    static func toDomain(from dto: TMDBMovie) -> MovieModel {
        return MovieModel(
            id: dto.id,
            posterImage: imageBaseURL + dto.poster_path,
            title: dto.title,
            audienceCount: "10만"
        )
    }
}

struct MovieDetailMapper {
    private static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    static func toDomain(from dto: TMDBMovie) -> MovieDetail {
        return MovieDetail(
            id: dto.id,
            headerImage: imageBaseURL + dto.backdrop_path,
            posterImage: imageBaseURL + dto.poster_path,
            title: dto.title,
            engTitle: dto.original_title,
            description: dto.overview.isEmpty ? "줄거리 정보가 없습니다." : dto.overview,
            ageRating: dto.adult ? "19" : "12",
            releaseDate: dto.release_date
        )
    }
}
