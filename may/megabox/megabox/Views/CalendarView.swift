//
//  CalendarView.swift
//  megabox
//
//  Created by 백지은 on 10/11/25.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @State private var viewModel: CalendarViewModel = .init()

    var body: some View {
        HStack(spacing: 5) {
            ForEach(viewModel.weekDays, id: \.self) { date in
                let isSelected = viewModel.calendar.isDate(selectedDate, inSameDayAs: date)

                VStack(spacing: 5) {
                    Text(viewModel.formattedDayNumber(from: date))
                        .font(.bold18)
                        .foregroundStyle(isSelected ? .white : viewModel.textColor(for: date))

                    Text(viewModel.formattedWeekday(from: date))
                        .font(.semiBold14)
                        .foregroundStyle(isSelected ? .white : viewModel.textColor(for: date))
                }
                .frame(width: 50, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? Color.purple03 : .clear)
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        selectedDate = date
                    }
                }
            }
        }
        .onAppear {
            if selectedDate == Date() {
                selectedDate = viewModel.weekDays.first ?? Date()
            }
        }
    }
}

#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
