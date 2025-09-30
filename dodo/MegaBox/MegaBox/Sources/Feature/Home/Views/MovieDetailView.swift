//
//  MovieDetailView.swift
//  MegaBox
//
//  Created by 김도연 on 10/1/25.
//

import SwiftUI

struct MovieDetailView: View {
    @State var movie: MovieDetail
    @State private var selectedTab: DetailTab = .info
    
    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                movie.headerImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 248)
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
            movie.posterImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 120)
            
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
            headerImage: Image(.movieDetailHeader),
            posterImage: Image(.poster1),
            title: "F1 더 무비",
            engTitle: "F1 : The Movie",
            description: "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 급격한 사고로 F1에서 우승하지 못하고,\n한순간에 추락한 드라이버 '손: 헤이스'(브래드 피트).\n그의 오랜 동료인 '루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.",
            ageRating: "12세 이상 관람가",
            releaseDate: "2025.06.25 개봉"
        ))
    }
}
