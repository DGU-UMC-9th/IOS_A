//
//  ScreeningView.swift
//  MegaBox
//
//  Created by 김도연 on 10/13/25.
//

import SwiftUI

struct ScreeningView: View {
    let screening: ScreeningSchedule
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(screening.branch)
                    .font(.bold18)
                
                ForEach(screening.theaters) { theater in
                    TheaterSection(theater: theater)
                }
            }
            .padding(.bottom, 20)
        }
    }
}

struct TheaterSection: View {
    let theater: Theaters
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TheaterHeader(name: theater.theaterName, screenType: theater.screenType)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 8) {
                ForEach(theater.times) { screening in
                    ScreeningTimeCard(screening: screening)
                }
            }
        }
    }
}

struct TheaterHeader: View {
    let name: String
    let screenType: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.bold18)
            Spacer()
            Text(screenType)
                .font(.bold18)
        }
    }
}

struct ScreeningTimeCard: View {
    let screening: Screening
    
    var body: some View {
        NavigationLink {
            // 좌석 선택 화면으로 이동
            Text("좌석 선택")
        } label: {
            VStack(spacing: 4) {
                Text(screening.startTime)
                    .font(.bold18)
                
                Text("~\(screening.endTime)")
                    .font(.regular13)
                
                Divider()
                
                SeatInfo(available: screening.availableSeats, total: screening.totalSeats)
            }
            .foregroundStyle(.black)
            .frame(maxHeight: 60)
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray02)
            )
        }
    }
}

struct SeatInfo: View {
    let available: Int
    let total: Int
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(available)/")
                .font(.semiBold14)
                .foregroundStyle(.purple03)
            
            Text("\(total)")
                .font(.semiBold14)
        }
    }
}

#Preview {
    ScreeningView(screening:
        ScreeningSchedule(
            date: "2025-09-22",
            branch: "강남",
            theaters: [
                Theaters(
                    theaterName: "크리클라이너 1관",
                    screenType: "2D",
                    times: [
                        Screening(startTime: "11:30", endTime: "13:58", availableSeats: 109, totalSeats: 116),
                        Screening(startTime: "14:20", endTime: "16:48", availableSeats: 19, totalSeats: 116),
                        Screening(startTime: "17:05", endTime: "19:28", availableSeats: 1, totalSeats: 116),
                        Screening(startTime: "19:45", endTime: "22:02", availableSeats: 100, totalSeats: 116),
                        Screening(startTime: "22:20", endTime: "00:04", availableSeats: 116, totalSeats: 116)
                    ]
                ),
                Theaters(
                    theaterName: "BTS관 (7층 1관 [Laser])",
                    screenType: "2D",
                    times: [
                        Screening(startTime: "09:30", endTime: "11:50", availableSeats: 75, totalSeats: 116),
                        Screening(startTime: "12:00", endTime: "14:26", availableSeats: 102, totalSeats: 116),
                        Screening(startTime: "14:45", endTime: "17:04", availableSeats: 88, totalSeats: 116)
                    ]
                )
            ]
        )
    )
}
