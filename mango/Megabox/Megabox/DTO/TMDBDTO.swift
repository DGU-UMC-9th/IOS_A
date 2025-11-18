//
//  TMDBDTO.swift
//  Megabox
//
//  Created by 송민교 on 11/17/25.
//
import Foundation

struct NowPlayingRequestDTO: Codable{
    let language: String
    let page: Int
    let region: String?
}

struct NowPlayingResponseDTO: Codable{
    let dates: DatesDTO
    let page: Int
    let results: [TMDBMovieDTO]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page, results, dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct DatesDTO: Codable{
    let maximum: String
    let minimum: String
}

struct TMDBMovieDTO: Codable{
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool
    let voteAverage: Double // 평균 평점
    let voteCount: Int
    
    private enum CodingKeys: String, CodingKey {
            case id, title, overview, adult, video, popularity
            case originalTitle = "original_title"
            case originalLanguage = "original_language"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
        }
}
