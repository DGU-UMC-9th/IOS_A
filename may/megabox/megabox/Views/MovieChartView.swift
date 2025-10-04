//
//  MovieChartView.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI

struct MovieChartView: View {
    
    var chartList: [MovieModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(chartList, id: \MovieModel.title) { (movie: MovieModel) in
                    
                    VStack(alignment: .leading, spacing: 12) {
                        NavigationLink(destination: MovieDetailView(movie: movie.toDetail())) {
                                    movie.posterImage
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
                        
                        Text("누적 관객수 \(movie.audienceCnt)")
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
    MovieChartView(chartList: HomeViewModel().chartList)
}
