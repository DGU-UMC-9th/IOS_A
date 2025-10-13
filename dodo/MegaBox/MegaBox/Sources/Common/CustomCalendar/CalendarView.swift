//
//  CalendarView.swift
//  MegaBox
//
//  Created by 김도연 on 10/12/25.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    
    var body: some View {
            let viewModel = CalendarViewModel(selectedDate: $selectedDate)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 40), count: 7),
                spacing: 5
            ) {
                ForEach(viewModel.weekDaysFromToday()) { day in
                    CalendarCell(
                        day: day,
                        isSelected: viewModel.isDateSelected(day.date)
                    ) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                            viewModel.selectDate(day.date)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
}

struct CalendarCell: View {
    let day: CalendarDay
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Text(day.displayText)
                .font(.bold18)
            
            Text(day.weekdayText)
                .font(.semiBold14)
        }
        .foregroundStyle(isSelected ? .white : day.textColor)
        .frame(minWidth: 50, minHeight: 60)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? .purple03 : .clear)
        )
        .onTapGesture(perform: onTap)
    }
}

#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
