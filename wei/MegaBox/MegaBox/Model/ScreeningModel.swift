//
//  ScreeningModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/12/25.
//

import Foundation

struct ScreeningModel: Identifiable, Hashable {
    let id: UUID
    let movieId: UUID
    let theaterId: UUID
    let info: String      // 2D 이런거
    let startAt: Date
    let endAt: Date
    var seatsTotal: Int
    var seatsAvailable: Int
    
    init(
        id: UUID = UUID(),
        movieId: UUID,
        theaterId: UUID,
        info: String,
        startAt: Date,
        endAt: Date,
        seatsTotal: Int,
        seatsAvailable: Int
    ) {
        self.id = id
        self.movieId = movieId
        self.theaterId = theaterId
        self.info = info
        self.startAt = startAt
        self.endAt = endAt
        self.seatsTotal = seatsTotal
        self.seatsAvailable = seatsAvailable
    }
}
