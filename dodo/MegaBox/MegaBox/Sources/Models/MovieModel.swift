//
//  MovieModel.swift
//  MegaBox
//
//  Created by 김도연 on 9/29/25.
//

import Foundation
import SwiftUI

struct MovieModel: Identifiable {
    let id: Int
    var posterImage: String
    var title: String
    var audienceCount: String
}

struct MovieDetail: Identifiable {
    let id: Int
    var headerImage: String
    var posterImage: String
    var title: String
    var engTitle: String
    var description: String
    var ageRating: String
    var releaseDate: String
}

struct MovieFeed: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var posterImage: Image
}
