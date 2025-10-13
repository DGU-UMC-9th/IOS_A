//
//  CalendarViewModel.swift
//  MegaBox
//
//  Created by 김도연 on 10/12/25.
//

import SwiftUI
import Foundation

@Observable
class CalendarViewModel {
    var selectedDate: Date
    let calendar: Calendar
    
    init(selectedDate: Date = Date(), calendar: Calendar = .current) {
        self.selectedDate = selectedDate
        self.calendar = calendar
    }
    
    /// 오늘부터 7일간의 날짜를 CalendarDay 배열로 반환
    func weekDaysFromToday() -> [CalendarDay] {
        (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: Date())
                .map { CalendarDay(date: $0, dayOffset: offset) }
        }
    }
    
    /// 선택된 날짜 변경
    func selectDate(_ date: Date) {
        guard !calendar.isDate(selectedDate, inSameDayAs: date) else { return }
        selectedDate = date
    }
}

