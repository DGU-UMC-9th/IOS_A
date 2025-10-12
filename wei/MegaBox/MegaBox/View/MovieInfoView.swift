//
//  MovieInfoView.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation
import SwiftUI

struct MovieInfoView: View {
    
    let movie: Movie
    var viewModel : MovieInfoViewModel = .init()
    @Environment(\.dismiss) private var dismiss
    
    private var movieInfo: MovieInfo? {
        viewModel.movieInfo.first(where: { $0.name == movie.name })
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing:35) {
                if let info = movieInfo {
                    movieDescription(info: info)
                    BottomView(info: info, movie: movie)
                } else {
                    Text("영화 정보를 찾을 수 없습니다")
                }
                
            }
        }
        .navigationTitle(movie.name)
}
    
    private func movieDescription(info: MovieInfo) -> some View {
        VStack(spacing:9){
            Image(info.poster)
            VStack{
                Text(info.name)
                    .font(.bold24)
                    .foregroundStyle(Color.black)
                Text(info.englishName)
                    .font(.semiBold14)
                    .foregroundStyle(Color.gray03)
            }
            .padding(.horizontal,16)
            
            Text(info.description)
                .font(.semiBold18)
                .foregroundStyle(Color.gray03)
                .padding(.horizontal,22)
        }
        
    }
    
    private func BottomView(info: MovieInfo, movie: Movie) -> some View {
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
                Image(movie.imageName)
                    .resizable()
                    .frame(width: 100, height: 120)
                VStack(alignment: .leading, spacing: 8){
                    Text("\(info.age)세 이상 관람가")
                        .font(.semiBold13)
                        .foregroundStyle(Color.black)
                    Text("\(info.date) 개봉")
                        .font(.semiBold13)
                        .foregroundStyle(Color.black)
                    Spacer()
                }
            }
            .padding(.trailing,200)
            .padding(.leading,24)
        }
        
    }
    
    
}

#Preview {
    NavigationStack {
        MovieInfoView(movie: Movie(
            name: "f1: 더 무비",
            imageName: "f1",
            audience: "20만"
        ))
    }
}
