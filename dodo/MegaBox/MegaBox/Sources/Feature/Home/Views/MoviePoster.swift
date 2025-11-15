//
//  MoviePoster.swift
//  MegaBox
//
//  Created by 김도연 on 9/29/25.
//

import SwiftUI
import NukeUI

struct MoviePoster: View {
    @Environment(HomeViewModel.self) private var viewModel
    @State var movie: MovieModel
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink {
                if let movieDetail = viewModel.getMovieDetail(by: movie.id) {
                    MovieDetailView(movie: movieDetail)
                } else {
                    // fallback - 상세 정보를 찾지 못한 경우
                    MovieDetailView(
                        movie: MovieDetail(
                            id: movie.id,
                            headerImage: movie.posterImage,
                            posterImage: movie.posterImage,
                            title: movie.title,
                            engTitle: movie.title,
                            description: "영화 정보를 불러올 수 없습니다.",
                            ageRating: "전체 관람가",
                            releaseDate: "개봉 예정"
                        )
                    )
                }
            } label: {
                LazyImage(url: URL(string: movie.posterImage)) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else if state.error != nil {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            )
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 212)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            NavigationLink {
                //TODO: 바로 예매 View 연동 예정
            } label: {
                Text("바로 예매")
                    .font(.medium16)
                    .foregroundStyle(.purple03)
                    .frame(width: 148, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.purple03)
                    )
            }
            Text(movie.title)
                .font(.bold22)
                .lineLimit(1)
                .foregroundStyle(.black)
            Text("누적관객수 \(movie.audienceCount)")
                .lineLimit(1)
                .font(.medium18)
                .foregroundStyle(.gray)
        }
        .frame(width: 148)
        .padding([.leading, .bottom], 6)
    }
}

#Preview {
    NavigationStack {
        MoviePoster(
            movie: MovieModel(
                id: 1,
                posterImage: "https://image.tmdb.org/t/p/w500/example.jpg",
                title: "예제 영화",
                audienceCount: "10만"
            )
        )
        .environment(HomeViewModel())
    }
}
