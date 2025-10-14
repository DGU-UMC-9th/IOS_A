//
//  TheaterModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/12/25.
//

import Foundation
import SwiftUI

struct TheaterModel: Identifiable, Hashable {
    let id: UUID
    var name: String
    var region: String?
    
    init(id: UUID = UUID(), name: String, region: String?=nil) {
        self.id = id
        self.name = name
        self.region = region
    }
}
