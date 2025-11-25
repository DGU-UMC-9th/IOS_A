//
//  MenuItemModel.swift
//  MegaBox
//
//  Created by 이연우 on 11/25/25.
//

import Foundation

struct MenuItemModel: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let imageName: String
}
