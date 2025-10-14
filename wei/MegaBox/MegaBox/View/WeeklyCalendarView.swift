//
//  WeeklyCalendarView.swift
//  MegaBox
//
//  Created by 이연우 on 10/12/25.
//

import Foundation
import SwiftUI

struct WeekCalendarView: View {
    @Bindable var viewModel: CalendarViewModel
    @ObservedObject var reserveVM: ReserveViewModel
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(Array(weekDays().enumerated()), id: \.element) { index, date in
                let isSelected = viewModel.calendar.isDate(date, inSameDayAs: viewModel.selectedDate)
                
                VStack(spacing: 4) {
                    // 월.일 표시
                    Text(monthDayString(from: date))
                        .font(.bold18)
                        .foregroundStyle(isSelected ? Color.white : textColor(for: date))
                
                    // 오늘/내일/요일 표시
                    Text(dayLabel(for: index))
                        .font(.semiBold14)
                        .foregroundStyle(isSelected ? Color.white : Color.gray03)
                    
                }
                
                .frame(width: 48, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? Color.purple03 : Color.white)
                        .frame(width:55, height:60)
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        viewModel.changeSelectedDate(date)
                        reserveVM.selectedDate = date 
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    // 오늘부터 7일치 날짜 가져오기
    private func weekDays() -> [Date] {
        let today = Date()
        return (0..<7).compactMap { day in
            viewModel.calendar.date(byAdding: .day, value: day, to: today)
        }
    }
    
    // 오늘/내일/요일 라벨 반환
    private func dayLabel(for index: Int) -> String {
        switch index {
        case 0:
            return "오늘"
        case 1:
            return "내일"
        default:
            let date = weekDays()[index]
            return weekdayString(from: date)
        }
    }
    
    // 월.일 형식으로 변환 (예: "9.22")
    private func monthDayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M.d"
        return formatter.string(from: date)
    }
    
    // 요일 한글로 변환 (예: "일", "월")
    private func weekdayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
    
    // 날짜만 추출 (예: 22)
    private func day(from date: Date) -> Int {
        return viewModel.calendar.component(.day, from: date)
    }
    
    private func textColor(for date: Date) -> Color {
            let weekday = viewModel.calendar.component(.weekday, from: date)
            // weekday: 1=일요일, 2=월요일, ..., 7=토요일
            switch weekday {
            case 1: // 일요일
                return Color.red
            case 7: // 토요일
                return Color.tag
            default: // 평일
                return Color.black
            }
        }
    
}

//#Preview {
//    WeekCalendarView(viewModel: CalendarViewModel(), )
//}
