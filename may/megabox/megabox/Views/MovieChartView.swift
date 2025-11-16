//
//  MovieChartView.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI
import Kingfisher

struct MovieChartView: View {
    
    var chartList: [MovieModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(chartList, id: \.id) { movie in
                    
                    VStack(alignment: .leading, spacing: 12) {
                        NavigationLink(destination: MovieDetailView(movie: movie.toDetail())) {
                            KFImage(URL(string: movie.posterImage))
                                .placeholder {
                                    ProgressView()
                                        .frame(width: 148, height: 210)
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 148, height: 210)
                                .clipped()
                                .cornerRadius(8)
                        }
                        
                        Button {
                            // 예매 액션
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
                        
                        Text("누적 관객수 \(movie.audienceCount)")
                            .font(.medium18)
                    }
                    .frame(width: 148, alignment: .leading)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    MovieChartView(chartList: [
        MovieModel(
            id: 1,
            title: "어쩔수가없다",
            posterImage: "https://i.namu.wiki/i/Ki6QFbWHQvKs4AgKiw-UT9iz1H3635B597EhxSkpsmOBgJZ9W6VamUUobIisCxwlq-MAOkSkEXrKIBdBIBLAoA.webp",
            audienceCount: "20만",
            originalTitle: "Something",
            overview: "영화 설명",
            backdropPath: "/backdrop1.jpg",
            releaseDate: "2025-01-01",
            adult: true
        ),
        MovieModel(
            id: 2,
            title: "극장판 귀멸의 칼날: 무한성 편",
            posterImage: "https://i.namu.wiki/i/ne9LAq2mN1FAiYfmNNweKVLqfWhbNijT6NA8PFH17C7lhlo-1cV8Ay5iZIRuj8Bmscg7LxTOH5N0eU5V7Oj6wA.webp",
            audienceCount: "10만",
            originalTitle: "Demon Slayer",
            overview: "영화 설명",
            backdropPath: "/backdrop2.jpg",
            releaseDate: "2025-02-01",
            adult: true
        ),
        MovieModel(
            id: 3,
            title: "F1: 더 무비",
            posterImage: "https://i.namu.wiki/i/adv1wJeGLlNKhMLHvPupi2eu1Ruw4mFmcjAWjafTpVnaqIakitYIoC7ax-2Wy2edhd_g3A6mtd-0_l7j1pvuzA.webp",
            audienceCount: "20만",
            originalTitle: "F1: The Movie",
            overview: "영화 설명",
            backdropPath: "/backdrop3.jpg",
            releaseDate: "2025-03-01",
            adult: false
        )
    ])
}
