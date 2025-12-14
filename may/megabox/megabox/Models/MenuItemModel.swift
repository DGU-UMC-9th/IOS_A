//
//  MenuItemModel.swift
//  megabox
//
//  Created by 백지은 on 11/22/25.
//

import Foundation
import SwiftUI

struct MenuItemModel: Identifiable {
    let id = UUID()
    let title: String
    let price: Int
    let image: Image
    var badge: MenuBadge?
    var isSoldOut: Bool
}

enum MenuBadge {
    case best
    case recommended
}
