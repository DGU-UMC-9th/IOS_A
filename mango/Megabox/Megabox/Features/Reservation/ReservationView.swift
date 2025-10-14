//
//  ReservationView.swift
//  Megabox
//
//  Created by 송민교 on 10/4/25.
//

import SwiftUI

struct ReservationView: View {
    @ObservedObject private var movieViewModel: MovieSelectViewModel
    @ObservedObject private var calendarViewModel: CalendarViewModel
    @ObservedObject private var theaterInfoViewModel: TheaterInfoViewModel
    
    init(
        movieViewModel: MovieSelectViewModel,
        calendarViewModel: CalendarViewModel,
        theaterInfoViewModel: TheaterInfoViewModel
    ) {
        self.movieViewModel = movieViewModel
        self.calendarViewModel = calendarViewModel
        self.theaterInfoViewModel = theaterInfoViewModel
    }
    
    var body: some View {
        VStack{
            headerSection
            movieCardSection(movieViewModel: movieViewModel)
            theaterButtonSection
            dateSelectSection(calendarViewModel: calendarViewModel,
                              theaterInfoViewModel: theaterInfoViewModel)
            theaterSelectSection
            Spacer()
        }
    }
    
    var headerSection: some View{
        VStack{
            Spacer().frame(height: 41)
            Text("영화별 예매")
                .font(.pretend(type: .bold, size: 22))
                .foregroundStyle(Color.white)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .background(Color.purple03)
        .padding(.bottom, 10)
    }
    
    var theaterButtonSection: some View {
        let theaters: [TheaterType] = TheaterType.allCases
        
        return HStack(alignment:.top, spacing: 8){
            ForEach(theaters, id:\.self) { theater in
                Button(action:{
                    theaterInfoViewModel.toggleTheater(theater: theater)
                }){
                    Text(theater.rawValue)
                        .padding(10)
                        .font(.pretend(type: .semibold, size: 16))
                        .foregroundStyle(theaterInfoViewModel.selectedTheaters.contains(theater) ? Color.white : Color.gray05)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(theaterInfoViewModel.selectedTheaters.contains(theater) ? Color.purple03 : Color.gray01)
                        )
                }
                .disabled(movieViewModel.selectedMovie == nil)
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
    
    var theaterSelectSection: some View {
        // Build selected day string (MM.dd) from TheaterInfoViewModel.selectedDate
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MM.dd"
        let selectedDayString = formatter.string(from: theaterInfoViewModel.selectedDate)

        return ScrollView {
            ForEach(theaterInfoViewModel.selectedTheaters, id: \.self) { selectedTheater in
                let filtered = theaterInfoViewModel.allTheaterInfos.filter {
                    $0.theater == selectedTheater && $0.movieDate == selectedDayString
                }

                if filtered.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("선택한 조건에 상영 정보가 없습니다.")
                            .font(.pretend(type: .semibold, size: 16))
                            .foregroundStyle(Color.gray04)
                        Text("영화, 극장, 날짜를 확인해주세요.")
                            .font(.pretend(type: .regular, size: 14))
                            .foregroundStyle(Color.gray03)
                    }
                    .padding()
                } else {
                    ForEach(filtered) { info in
                        VStack(alignment: .leading, spacing: 16) {
                            Text(info.theater.rawValue)
                                .font(.pretend(type: .bold, size: 18))
                            Text(info.theaterDetail)
                                .font(.pretend(type: .bold, size: 18))
                            
                            HStack(spacing:36){
                                ForEach(info.movieTime){ timeInfo in
                                    VStack(spacing:4){
                                        Text(timeInfo.startTime)
                                            .font(.pretend(type: .bold, size: 16))
                                        Text("~\(timeInfo.endTime)")
                                            .font(.pretend(type: .regular, size: 12))
                                            .foregroundStyle(Color.gray03)
                                        Text("\(timeInfo.leftSeats) / \(timeInfo.totalSeats)")
                                            .font(.pretend(type: .semibold, size: 12))
                                            .foregroundStyle(Color.purple03)
                                    }
                                    .padding(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray02, lineWidth: 1)
                                    )
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                }
            }
        }
    }
}

#Preview {
    let m = MovieSelectViewModel()
    return ReservationView(
        movieViewModel: m,
        calendarViewModel: CalendarViewModel(),
        theaterInfoViewModel: TheaterInfoViewModel(movieVM: m)
    )
}

