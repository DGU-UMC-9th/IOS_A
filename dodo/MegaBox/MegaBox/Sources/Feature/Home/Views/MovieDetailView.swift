//
//  MovieDetailView.swift
//  MegaBox
//
//  Created by 김도연 on 10/1/25.
//

import SwiftUI
import NukeUI

struct MovieDetailView: View {
    @State var movie: MovieDetail
    @State private var selectedTab: DetailTab = .info
    
    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyImage(url: URL(string: movie.headerImage)) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        Color.gray04
                            .frame(height: 240)
                    }
                }
                Text(movie.title)
                    .font(.bold24)
                Text(movie.engTitle)
                    .font(.semiBold13)
                    .foregroundStyle(.gray04)
                Text(movie.description)
                    .padding(.horizontal, 4)
                    .font(.semiBold18)
                    .foregroundStyle(.gray04)
            }
            Spacer()
            tabBar
            // 탭 선택
            if selectedTab == .info {
                infoSection
            } else {
                reviewSection
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(movie.title)
                    .font(.headline)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var tabBar: some View {
        HStack(spacing: 0) {
            ForEach(DetailTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: 8) {
                        Text(tab.rawValue)
                            .font(.semiBold18)
                            .foregroundColor(selectedTab == tab ? .black : .gray04)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selectedTab == tab ? .black : .gray02)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 20)
    }
    
    var infoSection: some View {
        HStack(alignment: .top, spacing: 16) {
            LazyImage(url: URL(string: movie.posterImage)) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 120)
                } else {
                    Color.gray04
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.ageRating)
                    .font(.medium16)
                Text(movie.releaseDate)
                    .font(.medium16)
            }
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .frame(minHeight: 140, alignment: .top)
    }
    
    var reviewSection: some View {
        VStack(alignment: .leading) {
            Text("등록된 관람평이 없습니다.")
                .font(.medium16)
                .foregroundStyle(.gray04)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal, 8)
        .frame(minHeight: 140, alignment: .top)
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: MovieDetail(
            id: 1218925,
            headerImage: "https://image.tmdb.org/t/p/w500/gqTz24ZRsCP6AKjARmEivY7m0cK.jpg",
            posterImage: "https://image.tmdb.org/t/p/w500/Amu0HNWfpxo2ZaulueNVxDLADz8.jpg",
            title: "극장판 체인소 맨: 레제편",
            engTitle: "チェンソーマン レゼ篇",
            description: "데블 헌터로 일하는 소년 ‘덴지’는 조직의 배신으로 죽음에 내몰린 순간 전기톱 악마견 ‘포치타’와의 계약으로 하나로 합쳐져 누구도 막을 수 없는 존재 ‘체인소 맨’으로 다시 태어난다. 악마와 사냥꾼, 그리고 정체불명의 적들이 얽힌 잔혹한 전쟁 속에서 ‘레제’라는 이름의 미스터리한 소녀가 ‘덴지’ 앞에 나타나는데… ‘덴지’는 사랑이라는 감정에 이끌려 지금껏 가장 위험한 배틀에 몸을 던진다!",
            ageRating: "15세 이상 관람가",
            releaseDate: "2025.09.19 개봉"
        ))
    }
}
