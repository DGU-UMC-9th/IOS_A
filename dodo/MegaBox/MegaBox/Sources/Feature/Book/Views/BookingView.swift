//
//  BookingView.swift
//  MegaBox
//
//  Created by 김도연 on 10/12/25.
//

import SwiftUI

struct BookingView: View {
    @StateObject private var vm = BookingViewModel()
    @State private var showingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    movieList
                    theaterList
                    calendarSection
                    timeTable
                    Spacer()
                }
                .sheet(isPresented: $showingSheet) {
                    MovieSearchView{ selected in
                        vm.selectedMovie = selected
                    }
                    .presentationDragIndicator(.visible)
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("영화별 예매")
                            .font(.bold22)
                            .foregroundStyle(.white)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible)
                .toolbarBackground(.purple03)
            }
        }
    }
    
    var movieList: some View {
        VStack {
            HStack {
                if let movie = vm.selectedMovie {
                    Text("\(movie.ageRating)")
                        .foregroundStyle(.white)
                        .font(.bold18)
                        .frame(width: 26, height: 26)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(.orange)
                        )
                    Text(movie.title)
                        .font(.bold18)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                } else {
                    Text("영화를 선택해주세요")
                        .font(.bold18)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button {
                    self.showingSheet.toggle()
                } label: {
                    Text("전체영화")
                        .font(.semiBold14)
                        .foregroundStyle(.black)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray02)
                        )
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(vm.movieList, id: \.id) { movie in
                        Button {
                            vm.selectedMovie = movie
                        } label: {
                            movie.posterImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(vm.selectedMovie?.title == movie.title ? .purple03 : .clear, lineWidth: 3)
                                        .padding(1)
                                )
                        }
                    }
                }
                .padding(.bottom, 12)
            }
        }
    }
    
    var theaterList: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Theater.allCases, id: \.self) { theater in
                        Button {
                            if vm.selectedTheaters.contains(theater) {
                                vm.selectedTheaters.remove(theater)
                            } else {
                                vm.selectedTheaters.insert(theater)
                            }
                        } label: {
                            Text(theater.title)
                                .font(.semiBold16)
                                .foregroundStyle(vm.selectedTheaters.contains(theater) ? .white : .gray04)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .foregroundStyle(vm.selectedTheaters.contains(theater) ? .purple03 : .gray02)
                                )
                        }
                        .disabled(!vm.isTheaterSelectionEnabled)
                        .opacity(vm.isTheaterSelectionEnabled ? 1 : 0)
                    }
                }
            }
        }
    }
    
    var calendarSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            CalendarView(selectedDate: $vm.selectedDate)
                .disabled(!vm.isDateSelectionEnabled)
                .opacity(vm.isDateSelectionEnabled ? 1 : 0)
        }
    }

    var timeTable: some View {
        VStack(spacing: 16) {
            if vm.filteredSchedules.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "film")
                        .font(.system(size: 40))
                        .foregroundStyle(.gray)
                    
                    if vm.selectedMovie == nil {
                        Text("영화를 선택해주세요")
                    } else if vm.selectedTheaters.isEmpty {
                        Text("극장을 선택해주세요")
                    } else {
                        Text("상영 스케줄이 없습니다")
                    }
                }
                .font(.body)
                .foregroundStyle(.secondary)
            } else {
                ForEach(vm.filteredSchedules, id: \.id) { schedule in
                    ScreeningView(screening: schedule)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookingView()
    }
}
