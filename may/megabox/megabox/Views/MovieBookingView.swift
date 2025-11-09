//
//  MovieBookingView.swift
//  megabox
//
//  Created by 백지은 on 10/11/25.
//

import SwiftUI
import Combine

struct MovieBookingView: View {
    @StateObject private var viewModel = MovieBookingViewModel()
    @State private var isShowingMovieSelection = false
    
    var body: some View {
        VStack{
            navigationBar
            movieSelectSection
            theaterSelectSection
            dateSelectSection
            
            if viewModel.shouldShowSchedule {
                movieScheduleSection
            }
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
    }
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(.purple03)
                .frame(height: 118)
            Text("영화별예매")
                .font(.bold22)
                .foregroundStyle(.white)
                .padding(.bottom, 12)
        }
    }
    
    // MARK: - movieSelectSection
    private var movieSelectSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                if let movie = viewModel.selectedMovie {
                    Text(movie.ageRating == "ALL" ? "A" : movie.ageRating)
                        .foregroundStyle(.white)
                        .font(.bold18)
                        .frame(width: 26, height: 26)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(movie.ageRating == "ALL" ? .green : .orange)
                        )
                }
                
                Spacer().frame(width: 20)
                
                Text(viewModel.selectedMovie?.title ?? "영화를 선택해주세요")
                    .font(.bold18)
                    .foregroundColor(viewModel.selectedMovie == nil ? .gray : .primary)
                    .lineLimit(1)
                
                Spacer()
                
                Button {
                    viewModel.resetSelection()
                    isShowingMovieSelection = true
                } label: {
                    Text("전체영화")
                        .font(.semiBold14)
                        .foregroundStyle(.black)
                        .frame(width: 69, height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray02)
                        )
                }
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $isShowingMovieSelection) {
                MovieSelectionView { selected in
                    viewModel.selectedMovie = selected
                    isShowingMovieSelection = false
                }
                .presentationDetents([.large, .large])
                .presentationDragIndicator(.visible)
            }
            
            // 로딩 표시
            if viewModel.isLoading {
                HStack {
                    ProgressView()
                    Text("영화 로딩 중...")
                        .font(.medium14)
                        .foregroundStyle(.gray05)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            }
            // 에러 표시
            else if let error = viewModel.errorMessage {
                Text(error)
                    .font(.medium14)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
            }
            // 영화 목록 표시
            else if !viewModel.movieList.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.movieList) { movie in
                            Button {
                                viewModel.selectedMovie = movie
                                print("선택된 영화: \(movie.title)")
                            } label: {
                                movie.posterImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 89)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                viewModel.selectedMovie?.id == movie.id
                                                ? .purple03
                                                : .clear,
                                                lineWidth: 3
                                            )
                                            .padding(1)
                                    )
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 16)
    }
    
    // MARK: - theaterSelectSection
    private var theaterSelectSection: some View {
        HStack(spacing: 16) {
            ForEach(Theater.allCases, id: \.self) { theater in
                Button {
                    if viewModel.selectedTheaters.contains(theater) {
                        viewModel.selectedTheaters.remove(theater)
                    } else {
                        viewModel.selectedTheaters.insert(theater)
                    }
                } label: {
                    Text(theater.title)
                        .font(.semiBold16)
                        .foregroundStyle(viewModel.selectedTheaters.contains(theater) ? .white : .gray05)
                        .frame(width: 55, height: 35)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(viewModel.selectedTheaters.contains(theater) ? .purple03 : .gray01)
                        )
                }
                .disabled(!viewModel.canSelectTheater)
                .opacity(viewModel.canSelectTheater ? 1.0 : 0)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - dateSelectSection
    private var dateSelectSection: some View {
        VStack(spacing: 0) {
            CalendarView(selectedDate: $viewModel.selectedDate)
        }
        .disabled(!viewModel.canSelectDate)
        .opacity(viewModel.canSelectDate ? 1.0 : 0)
        .padding(.horizontal, 16)
    }
    
    // MARK: - movieScheduleSection
    private var movieScheduleSection: some View {
        let sortedTheaters = Array(viewModel.selectedTheaters).sorted(by: { $0.rawValue < $1.rawValue })
        
        let hasAnySchedule = sortedTheaters.contains { theater in
            if let schedules = viewModel.schedulesToShow[theater] {
                return !schedules.isEmpty
            }
            return false
        }
        
        return ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if hasAnySchedule {
                    ForEach(sortedTheaters, id: \.self) { theater in
                        if let schedules = viewModel.schedulesToShow[theater], !schedules.isEmpty {
                            TheaterScheduleView(theaterName: theater.title, schedules: schedules)
                        }
                    }
                } else {
                    Text("선택한 극장에 상영시간표가 없습니다")
                        .font(.medium14)
                        .foregroundStyle(.gray05)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 20)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    MovieBookingView()
}
