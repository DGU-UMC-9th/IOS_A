//
//  CalendarViewModel.swift
//  megabox
//
//  Created by 백지은 on 10/11/25.
//

import SwiftUI
import Foundation

@Observable
class CalendarViewModel {
    let calendar: Calendar

    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

    /// 오늘부터 7일간 날짜
    var weekDays: [Date] {
        let today = Date()
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: today) }
    }

    /// 요일 인덱스
    func weekdayIndex(for date: Date) -> Int {
        calendar.component(.weekday, from: date)
    }

    /// 일자 포맷
    func formattedDayNumber(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    /// 요일 포맷 ("오늘", "내일", 아니면 기존 요일)
    func formattedWeekday(from date: Date) -> String {
        if calendar.isDateInToday(date) {
            return "오늘"
        } else if calendar.isDateInTomorrow(date) {
            return "내일"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "E"
            return formatter.string(from: date)
        }
    }

    /// 요일 색상 (일요일: 빨강, 토요일: 파랑)
    func textColor(for date: Date) -> Color {
        switch weekdayIndex(for: date) {
        case 1: return .red      // 일요일
        case 7: return .blue     // 토요일
        default: return .black   // 평일
        }
    }
}
