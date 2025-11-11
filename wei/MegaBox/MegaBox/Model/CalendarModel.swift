//
//  CalendarModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/12/25.
//

import Foundation

struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
}
