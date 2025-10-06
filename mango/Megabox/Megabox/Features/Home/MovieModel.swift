//
//  HomeModel.swift
//  Megabox
//
//  Created by 송민교 on 10/5/25.
//

import SwiftUI
import Foundation

struct MovieModel: Identifiable, Hashable{
    var id = UUID()
    var movieTitle: String
    var movieCount: String
    var movieImageName: String
    
    let topPosterImageName: String
    let bottomPosterImageName: String
    let originalTitle: String
    let tagline: String
    let synopsis: String
    let rating: String
    let releaseDate: String
}
