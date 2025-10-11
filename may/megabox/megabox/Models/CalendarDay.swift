//
//  CalendarDay.swift
//  megabox
//
//  Created by 백지은 on 10/11/25.
//

import Foundation

struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
}
