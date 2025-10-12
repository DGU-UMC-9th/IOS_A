//
//  MovieModel.swift
//  Week4_Practice
//
//  Created by 이연우 on 10/12/25.
//

import Foundation
import SwiftUI

struct MovieModel : Identifiable {
    let id : UUID = .init()
    let movieImage : Image
    let title: String
    let rate: Double
}
