//
//  MenuItemModel.swift
//  MegaBox
//
//  Created by 김도연 on 11/19/25.
//

import Foundation

struct MenuItemModel: Identifiable {
    let id = UUID()
    let title: String
    let price: String
    let image: String
    let badge: BadgeType?
    let isAvailable: Bool
    let salesPrice: String?
}
