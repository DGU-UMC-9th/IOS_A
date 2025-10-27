//
//  MovieSearchModel.swift
//  umc9
//
//  Created by 백지은 on 10/11/25.
//

import Foundation
import SwiftUI

struct MovieSearchModel: Identifiable {
    let id: UUID = .init()
    let movieImage: Image
    let title: String
    let rate: Double
}
