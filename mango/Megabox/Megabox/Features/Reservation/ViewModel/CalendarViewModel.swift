//
//  CalendarViewModel.swift
//  Megabox
//
//  Created by 송민교 on 10/12/25.
//

import SwiftUI


class CalendarViewModel:ObservableObject{
    @Published var selectedDate: Date
    var calendar: Calendar
    
    // 오늘 날짜로 초기화, 현재 시스템의 달력 사용
    init(selectedDate: Date = Date(), calendar: Calendar = .current) {
        self.selectedDate = selectedDate
        self.calendar = calendar
    }
    
    // 오늘을 기준으로 7일치 날짜 정보를 배열로 반환하는 함수
    func nextSevenDays(from today: Date = Date()) ->  [(weekday: String, monthDay: String, day: String, date: Date)] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        
        // compactMap을 통해 nil 아닌 값만 반환
        return (0..<7).compactMap{ offset in
            // .day는 하루 단위로 더하기 -> today + offset(0~6)
            guard let date = calendar.date(byAdding: .day, value: offset, to: today) else { return nil }
            
            // 요일
            formatter.dateFormat = "E"
            let weekday = formatter.string(from: date)
            
            // 월
            formatter.dateFormat = "MM"
            let month = formatter.string(from: date)
            
            // 일
            formatter.dateFormat = "dd"
            let day = formatter.string(from:date)
            
            return (weekday:weekday, monthDay: month, day:day, date:date)
        }
    }
    
    // 사용자가 다른 날짜를 선택했을 때
    func changeSelectedDate(_ date: Date){
        if !calendar.isDate(selectedDate, inSameDayAs: date){
            selectedDate = date
        }
    }
}
