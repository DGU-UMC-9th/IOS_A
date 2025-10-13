//
//  MoviePoster.swift
//  MegaBox
//
//  Created by 김도연 on 9/29/25.
//

import SwiftUI

struct MoviePoster: View {
    @State var movie: MovieModel
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink {
                //MARK: - 지금은 그냥 하드코딩 식으로 F1영화만 정보 제대로 가져올 수 있도록 제작. API연동을 한다면 movieID로 요청 보내서 MovieDetail모델에 맞춰 response받아와서 띄워주는 방식.
                if movie.title == "F1: 더 무비" {
                    MovieDetailView(
                        movie:
                            MovieDetail(
                                headerImage: Image(.movieDetailHeader),
                                posterImage: movie.posterImage,
                                title: movie.title,
                                engTitle: "F1 : The Movie",
                                description: "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키 한때 주목받는 유망주였지만 끔찍한 사고로 F1에서  우승하지 못하고 한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트). 그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.",
                                ageRating: "12세 이상 관람가",
                                releaseDate: movie.title
                            )
                    )
                } else {
                    MovieDetailView(
                        movie:
                            MovieDetail(
                                headerImage: movie.posterImage,
                                posterImage: movie.posterImage,
                                title: movie.title,
                                engTitle: "English Title",
                                description: "설명 설명",
                                ageRating: "00세 이상 관람가",
                                releaseDate: movie.title
                            )
                    )
                }
            } label: {
                movie.posterImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 212)
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
            Text("누적관객수 \(movie.audienceCount)")
                .lineLimit(1)
                .font(.medium18)
        }
        .frame(width: 148)
        .padding([.leading, .bottom], 6)
    }
}

#Preview {
    NavigationStack {
        MoviePoster(movie: HomeViewModel().posterList[0])
    }
}
