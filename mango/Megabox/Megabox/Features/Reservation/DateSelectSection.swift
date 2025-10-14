//
//  DateSelectSection.swift
//  Megabox
//
//  Created by 송민교 on 10/13/25.
//

import SwiftUI

struct dateSelectSection: View{
    @ObservedObject var calendarViewModel: CalendarViewModel
    @ObservedObject var theaterInfoViewModel: TheaterInfoViewModel
    
    var body: some View{
        let dates: [(weekday: String, monthDay: String, day: String, date: Date)] = calendarViewModel.nextSevenDays()
        
        HStack(alignment: .top, spacing: 0){
            ForEach(dates, id: \.date){ datesInfo in
                let isToday = Calendar.current.isDateInToday(datesInfo.date)
                let isSelected = calendarViewModel.calendar.isDate(calendarViewModel.selectedDate, inSameDayAs: datesInfo.date)
                
                VStack(spacing:8){
                    Text(isToday ? "\(datesInfo.monthDay).\(datesInfo.day)" : datesInfo.day)
                        .font(.pretend(type: .bold, size: 18))
                        .foregroundStyle(isSelected ? Color.white : textColor(weekday: datesInfo.weekday))
                    Text(isToday ? "오늘" : datesInfo.weekday)
                        .font(.pretend(type: .semibold, size: 14))
                        .foregroundStyle(isSelected ? Color.white : textColor(weekday: datesInfo.day))
                }
                .contentShape(Rectangle())
                .frame(width: 55, height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? Color.purple03 : Color.clear)
                )
                .onTapGesture {
                    calendarViewModel.changeSelectedDate(datesInfo.date)
                    theaterInfoViewModel.selectedDate = datesInfo.date
                }
            }
        }
    }
}
func textColor(weekday: String) -> Color{
    switch weekday {
    case "토": return Color(red: 0.28, green: 0.8, blue: 0.82)
    case "일": return Color(red: 1, green: 0.04, blue: 0.04)
    default: return Color.black
    }
}

