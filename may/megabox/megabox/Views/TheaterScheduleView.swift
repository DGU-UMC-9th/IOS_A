//
//  TheaterScheduleView.swift
//  megabox
//
//  Created by 백지은 on 10/11/25.
//

import SwiftUI

struct TheaterScheduleView: View {
    let theaterName: String
    let schedules: [ScreeningSchedule]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(theaterName)
                .font(.bold18)
            
            ForEach(schedules) { schedule in
                ScreeningScheduleRow(schedule: schedule)
            }
        }
    }
}

struct ScreeningScheduleRow: View {
    let schedule: ScreeningSchedule
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(schedule.theaterName)
                    .font(.semiBold16)
                Spacer()
                Text(schedule.screenType)
                    .font(.medium14)
                    .foregroundStyle(.black)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(schedule.times) { time in
                    ScreeningTimeButton(time: time)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ScreeningTimeButton: View {
    let time: ScreeningTime
    
    var body: some View {
        Button {
            
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Text(time.startTime)
                    .font(.bold18)
                    .foregroundStyle(.black)
                Text("~\(time.endTime)")
                    .font(.regular12)
                    .foregroundStyle(.gray03)
                HStack(spacing: 0) {
                    Text("\(time.availableSeats)")
                        .font(.semiBold14)
                        .foregroundStyle(.purple03)
                    Text(" / \(time.totalSeats)")
                        .font(.semiBold14)
                        .foregroundStyle(.gray04)
                }
            }
            .padding(.vertical, 8)
            .frame(width: 75)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray02)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    TheaterScheduleView(
        theaterName: "강남",
        schedules: [
            ScreeningSchedule(
                theaterName: "크리클라이너 1관",
                screenType: "2D",
                times: [
                    ScreeningTime(startTime: "11:30", endTime: "13:58", availableSeats: 109, totalSeats: 116),
                    ScreeningTime(startTime: "14:20", endTime: "16:48", availableSeats: 19, totalSeats: 116),
                    ScreeningTime(startTime: "17:05", endTime: "19:28", availableSeats: 1, totalSeats: 116),
                    ScreeningTime(startTime: "19:45", endTime: "22:02", availableSeats: 100, totalSeats: 116),
                    ScreeningTime(startTime: "22:20", endTime: "00:04", availableSeats: 116, totalSeats: 116)
                ]
            ),
            ScreeningSchedule(
                theaterName: "BTS관 (7층 1관 [Laser])",
                screenType: "2D",
                times: [
                    ScreeningTime(startTime: "9:30", endTime: "11:50", availableSeats: 75, totalSeats: 116),
                    ScreeningTime(startTime: "12:00", endTime: "14:26", availableSeats: 102, totalSeats: 116),
                    ScreeningTime(startTime: "14:45", endTime: "17:04", availableSeats: 88, totalSeats: 116)
                ]
            )
        ]
    )
}
