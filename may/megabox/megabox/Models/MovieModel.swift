//
//  MovieModel.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI
import Foundation
import Kingfisher

import SwiftUI

struct MovieModel: Identifiable {
    let id: Int
    var title: String
    var posterImage: String
    var audienceCount: String
    
    // 원본 데이터 저장
    var originalTitle: String?
    var overview: String?
    var backdropPath: String?
    var releaseDate: String?
    var adult: Bool
}

extension MovieModel {
    func toDetail() -> MovieDetail {
        let backdropURL = backdropPath != nil ? "https://image.tmdb.org/t/p/w500" + backdropPath! : ""
        let posterURL = posterImage
        
        // 개봉일 형식 변환
        let formattedDate = releaseDate != nil ? formatReleaseDate(releaseDate!) : ""
        
        return MovieDetail(
            id: id,
            title: title,
            engTitle: originalTitle ?? title,
            description: overview ?? "",
            headerImage: backdropURL,
            posterImage: posterURL,
            ageRating: adult ? "19세 이상 관람가" : "12세 이상 관람가",
            releaseDate: formattedDate
        )
    }
    
    private func formatReleaseDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            return dateFormatter.string(from: date) + " 개봉"
        }
        return dateString + " 개봉"
    }
}

struct MovieDetail: Identifiable {
    let id: Int
    var title: String
    var engTitle: String
    var description: String
    var headerImage: String
    var posterImage: String
    var ageRating: String
    var releaseDate: String
}

struct MovieFeed: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var posterImage: Image
}

struct MovieBooking: Identifiable, Equatable {
    var id : String
    var posterImage: Image
    var title: String
    var ageRating: String
    
    static func == (lhs: MovieBooking, rhs: MovieBooking) -> Bool {
        return lhs.id == rhs.id
    }
}
