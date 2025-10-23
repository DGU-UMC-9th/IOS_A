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
    private var selectedDate: Binding<Date>
    let calendar: Calendar
    
    init(selectedDate: Binding<Date>, calendar: Calendar = .current) {
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
    
    /// 선택된 날짜 변경 시 Binding 값을 직접 업데이트합니다.
    func selectDate(_ date: Date) {
        // wrappedValue를 통해 Binding으로 연결된 원본 데이터를 변경합니다.
        selectedDate.wrappedValue = date
    }

    /// View에서 날짜 선택 여부를 확인할 때 사용할 헬퍼 함수
    func isDateSelected(_ date: Date) -> Bool {
        let currentSelectedDate = selectedDate.wrappedValue
        return calendar.isDate(date, inSameDayAs: currentSelectedDate)
    }
}
