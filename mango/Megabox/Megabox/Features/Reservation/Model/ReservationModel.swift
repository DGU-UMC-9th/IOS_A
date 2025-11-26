//
//  MovieSelectModel.swift
//  Megabox
//
//  Created by 송민교 on 10/12/25.
//

import Foundation
import SwiftUI

struct MovieSelectModel: Identifiable{
    let id = UUID()
    let movieImageName: String
    // let ageLimit: Int
    var title: String
    var isSelected: Bool
}

struct TheaterInfo: Identifiable{
    let id = UUID()
    let theater:TheaterType
    let movie: MovieSelectModel
    let theaterDetail: String
    let movieTime: [MovieTime]
    let movieDate: String
}

struct MovieTime: Identifiable{
    let id = UUID()
    let startTime: String
    let endTime: String
    let leftSeats: Int
    let totalSeats: Int
}
