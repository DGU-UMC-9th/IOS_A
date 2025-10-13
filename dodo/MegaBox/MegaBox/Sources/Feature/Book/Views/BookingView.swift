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
    private var movieSelected: Int = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    movieList
                    theaterList
                    CalendarView(viewModel: CalendarViewModel())
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
                        .foregroundColor(vm.selectedMovie == nil ? .gray : .primary)
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
                    ForEach(vm.moiveList, id: \.id) { movie in
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
        ScrollView(.horizontal) {
            HStack {
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
                }
            }
        }
    }

    var timeTable: some View {
        VStack {
            ForEach(vm.screeningSchedules, id: \.id){ schedule in
                ScreeningView(screening: schedule)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookingView()
    }
}
