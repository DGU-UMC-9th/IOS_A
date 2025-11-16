//
//  MovieDTO.swift
//  megabox
//
//  Created by 백지은 on 11/16/25.
//

import Foundation

struct TMDBMovie: Codable {
    let id: Int
    let title: String
    let original_title: String
    let overview: String
    let release_date: String
    let popularity: Double
    let vote_average: Double
    let vote_count: Int
    let adult: Bool
    let video: Bool
    let backdrop_path: String?
    let poster_path: String?
    let genre_ids: [Int]
    let original_language: String
}

struct Dates: Codable {
    let maximum: String
    let minimum: String
}

struct TMDBResponse: Codable {
    let dates: Dates?
    let page: Int
    let results: [TMDBMovie]
    let total_pages: Int
    let total_results: Int
}

struct MovieModelMapper {
    static func toDomain(from dto: TMDBMovie) -> MovieModel {
        let posterURL = dto.poster_path != nil ? "https://image.tmdb.org/t/p/w500" + dto.poster_path! : ""
        return MovieModel(
            id: dto.id,
            title: dto.title,
            posterImage: posterURL,
            audienceCount: "20만", // 하드코딩
            originalTitle: dto.original_title,
            overview: dto.overview,
            backdropPath: dto.backdrop_path,
            releaseDate: dto.release_date,
            adult: dto.adult
        )
    }
}

struct MovieDetailMapper {
    static func toDomain(from dto: TMDBMovie) -> MovieDetail {
        let posterURL = dto.poster_path != nil ? "https://image.tmdb.org/t/p/w500" + dto.poster_path! : ""
        let backdropURL = dto.backdrop_path != nil ? "https://image.tmdb.org/t/p/w500" + dto.backdrop_path! : ""
        
        // 개봉일 형식 변환 (YYYY-MM-DD -> YYYY.MM.DD 개봉)
        let formattedDate = formatReleaseDate(dto.release_date)
        
        return MovieDetail(
            id: dto.id,
            title: dto.title,
            engTitle: dto.original_title,
            description: dto.overview,
            headerImage: backdropURL,
            posterImage: posterURL,
            ageRating: dto.adult ? "19세 이상 관람가" : "12세 이상 관람가",
            releaseDate: formattedDate
        )
    }
    
    private static func formatReleaseDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            return dateFormatter.string(from: date) + " 개봉"
        }
        return dateString + " 개봉"
    }
}
