//
//  MovieDetailView.swift
//  megabox
//
//  Created by 백지은 on 10/5/25.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    
    @State var movie: MovieDetail
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedTab: DetailType = .info
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                navigationBar
                movieSection
                
                HStack(spacing: 0) {
                    tabButton(title: "상세 정보", type: .info)
                    tabButton(title: "실관람평", type: .review)
                }
                .padding(.vertical, 12)
                
                if selectedTab == .info {
                    infoSection
                } else {
                    reviewSection
                }
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var navigationBar: some View {
        ZStack {
            Text(movie.title)
                .font(.bold18)
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundStyle(.black)
                }
                Spacer()
            }
        }
        .padding(.top, 8)
    }
    
    private var movieSection: some View {
        VStack(alignment: .center, spacing: 7) {
            if let headerURL = URL(string: movie.headerImage), !movie.headerImage.isEmpty {
                KFImage(headerURL)
                    .placeholder {
                        ProgressView()
                            .frame(height: 248)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 248)
                    .frame(maxWidth: .infinity)
            } else {
                Color.gray02
                    .frame(height: 248)
                    .frame(maxWidth: .infinity)
            }
            
            VStack(alignment: .center, spacing: 9) {
                Text(movie.title)
                    .font(.bold24)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                Text(movie.engTitle)
                    .font(.semiBold14)
                    .foregroundStyle(.gray03)
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                Text(movie.description)
                    .font(.medium14)
                    .foregroundStyle(.gray04)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func tabButton(title: String, type: DetailType) -> some View {
        Button {
            selectedTab = type
        } label: {
            VStack(spacing: 4) {
                Text(title)
                    .font(.bold22)
                    .foregroundStyle(selectedTab == type ? .black : .gray)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(selectedTab == type ? .black : .clear)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private var infoSection: some View {
        HStack(alignment: .top, spacing: 12) {
            if let posterURL = URL(string: movie.posterImage), !movie.posterImage.isEmpty {
                KFImage(posterURL)
                    .placeholder {
                        ProgressView()
                            .frame(height: 120)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            } else {
                Color.gray02
                    .frame(height: 120)
            }
            
            VStack(alignment: .leading, spacing: 8){
                Text(movie.ageRating)
                    .font(.semiBold13)
                Text(movie.releaseDate)
                    .font(.semiBold13)
            }
        }
    }
    
    private var reviewSection: some View {
        VStack(alignment: .center) {
            Text("등록된 관람평이 없어요.")
                .font(.medium16)
                .foregroundStyle(.gray08)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
}

#Preview {
    MovieDetailView(movie: MovieDetail(
        id: 1,
        title: "F1 더 무비",
        engTitle: "F1 : The Movie",
        description: "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고 한순간에 추락한 드라이버 '손; 헤이스'(브래드 피트).\n그의 오랜 동료인 '루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.",
        headerImage: "https://img1.daumcdn.net/thumb/R1280x0.fwebp/?fname=http://t1.daumcdn.net/brunch/service/user/eAde/image/hAvz8GkXDWrUldW0cq94E0l8Tec.JPG",
        posterImage: "https://i.namu.wiki/i/adv1wJeGLlNKhMLHvPupi2eu1Ruw4mFmcjAWjafTpVnaqIakitYIoC7ax-2Wy2edhd_g3A6mtd-0_l7j1pvuzA.webp",
        ageRating: "12세 이상 관람가",
        releaseDate: "2025.06.25 개봉"
    ))
}
