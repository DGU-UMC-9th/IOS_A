//
//  MovieInfoView.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct MovieInfoView: View {
    
    let movie: MovieModel
    @State private var viewModel = MovieInfoViewModel()
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ScrollView {
            VStack(spacing:35) {
                if viewModel.isLoading {
                    ProgressView("영화 정보를 불러오는 중...")
                        .padding(.vertical, 100)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text("오류가 발생했습니다")
                            .font(.bold18)
                        Text(errorMessage)
                            .font(.medium14)
                            .foregroundColor(.gray03)
                        Button("다시 시도") {
                            Task {
                                    if let serverId = movie.serverId {
                                        await viewModel.fetchMovieDetail(movieId: serverId)
                                    }
                                }
                        }
                        .padding()
                        .background(Color.purple03)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding(.vertical, 100)
                } else if let info = viewModel.movieInfo {
                    movieDescription(info: info)
                    BottomView(info: info, movie: movie)
                } else {
                    Text("영화 정보를 찾을 수 없습니다")
                        .padding(.vertical, 100)
                }
                
            }
        }
        .navigationTitle(movie.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if let serverId = movie.serverId {
                            await viewModel.fetchMovieDetail(movieId: serverId)
                        }
        }
}
    
    private func movieDescription(info: MovieInfo) -> some View {
        VStack(spacing:9){
            KFImage(URL(string: info.poster))
                .placeholder {
                    Rectangle()
                        .fill(Color.gray02)
                        .frame(height: 400)
                        .overlay(
                            ProgressView()
                        )
                }
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipped()
            
            VStack(spacing: 4) {
                Text(info.name)
                    .font(.bold24)
                    .foregroundStyle(Color.black)
                    .multilineTextAlignment(.center)
                Text(info.englishName)
                    .font(.semiBold14)
                    .foregroundStyle(Color.gray03)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 16)
            
            Text(info.description)
                .font(.semiBold18)
                .foregroundStyle(Color.gray03)
                .padding(.horizontal, 22)
                .multilineTextAlignment(.center)
        }
        
    }
    
    private func BottomView(info: MovieInfo, movie: MovieModel) -> some View {
        VStack(spacing:10){
            HStack(spacing: 0) {
                        VStack(spacing: 8) {
                            Text("상세 정보")
                                .font(.bold22)
                                .foregroundStyle(Color.black)
                            
                            Rectangle()
                                .frame(height: 3)
                                .foregroundStyle(Color.black)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(spacing: 8) {
                            Text("실관람평")
                                .font(.bold22)
                                .foregroundStyle(Color.gray02)
                            
                            Rectangle()
                                .frame(height: 3)
                                .foregroundStyle(Color.gray02)
                        }
                        .frame(maxWidth: .infinity)
                    }
            
            HStack(alignment: .top, spacing: 16){
                KFImage(URL(string: movie.imageName))
                        .placeholder {
                            Rectangle()
                                .fill(Color.gray02)
                                .frame(width: 100, height: 120)
                                .overlay(
                                    ProgressView()
                                )
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 120)
                        .clipped()
                        .cornerRadius(4)
                
                VStack( spacing: 8){
                    Text("\(info.age)세 이상 관람가")
                        .font(.semiBold13)
                        .foregroundStyle(Color.black)
                    Text("\(info.date) 개봉")
                        .font(.semiBold13)
                        .foregroundStyle(Color.black)
                    Spacer()
                }
            }
            .padding(.trailing,180)
            //.padding(.leading,24)
        }
        
    }
    
    
}

#Preview {
    NavigationStack {
        MovieInfoView(movie: MovieModel(
            serverId: 502356,
            name: "슈퍼 마리오 브라더스",
            imageName: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
            audience: "20만",
            age: 12
        ))
    }
}
