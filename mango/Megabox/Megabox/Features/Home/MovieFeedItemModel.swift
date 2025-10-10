//
//  MovieFeedModel.swift
//  Megabox
//
//  Created by 송민교 on 10/6/25.
//

import SwiftUI
import Foundation

struct MovieFeedItemModel: Identifiable, Hashable{
    var id = UUID()
    var thumbnailName: String
    var title: String
    var subtitle: String
}
