//
//  MovieResponse.swift
//  MegaBox
//
//  Created by 이연우 on 11/23/25.
//

import Foundation

// MARK: - Now Playing Response
struct NowPlayingResponse: Codable {
    let dates: DateRange?
    let page: Int
    let results: [MovieResult]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct DateRange: Codable {
    let maximum: String
    let minimum: String
}


struct MovieResult: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


struct MovieDetailResponse: Codable {
    let adult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [Genre]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let title: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

extension MovieResult {
    func toMovieModel() -> MovieModel {
        let imageUrl = posterPath.map { "https://image.tmdb.org/t/p/w500\($0)" } ?? ""
        let audienceText = formatVoteCount(voteCount)
        let randomAge = [12, 15, 18].randomElement() ?? 15
        
        return MovieModel(
            id: UUID(),
            serverId: id,
            name: title,
            imageName: imageUrl,
            audience: audienceText,
            age: randomAge
        )
    }
    
    private func formatVoteCount(_ count: Int) -> String {
        if count >= 10000 {
            return "\(count / 10000)만"
        } else if count >= 1000 {
            return "\(count / 1000)천"
        }
        return "\(count)"
    }
}


extension MovieDetailResponse {
    func toMovieInfo() -> MovieInfo {
        let posterUrl = backdropPath.map { "https://image.tmdb.org/t/p/original\($0)" } ?? ""
        let randomAge = [12, 15, 18].randomElement() ?? 15
        
        return MovieInfo(
            name: title,
            englishName: originalTitle,
            description: overview,
            poster: posterUrl,
            date: releaseDate,
            age: randomAge
        )
    }
}
