//
//  CalendarDay.swift
//  MegaBox
//
//  Created by 김도연 on 10/12/25.
//

import Foundation
import SwiftUI

struct CalendarDay: Identifiable {
    let id = UUID()
    let date: Date
    let displayText: String
    let weekdayText: String
    let textColor: Color
    let isToday: Bool
    
    init(date: Date, dayOffset: Int) {
        self.date = date
        self.isToday = Calendar.current.isDateInToday(date)
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let weekday = calendar.component(.weekday, from: date)
        
        // 날짜 표시 텍스트
        switch dayOffset {
        case 0: self.displayText = "\(month).\(day)"
        default: self.displayText = "\(day)"
        }
        
        // 요일 표시 텍스트
        switch dayOffset {
        case 0: self.weekdayText = "오늘"
        case 1: self.weekdayText = "내일"
        default:
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "EEEEEE"
            self.weekdayText = formatter.string(from: date)
        }
        
        // 텍스트 색상
        self.textColor = switch weekday {
        case 1: .red      // 일요일
        case 7: .cyan     // 토요일
        default: .primary
        }
    }
}
