//
//  HomeView.swift
//  MegaBox
//
//  Created by 김도연 on 9/29/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: HomeType = .home
    @State var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                topTabView
                ScrollView {
                    Group {
                        switch selectedTab {
                        case .home: movieView
                        case .event: VStack{Text("EventView")}
                        case .store: VStack{Text("StoreView")}
                        case .prefer: VStack{Text("PreferView")}
                        }
                    }
                    .padding(.horizontal ,8)
                }
            }
        }
    }
    
    var topTabView: some View {
        VStack(alignment: .leading) {
            Image(.megaBoxSmallLogo)
            HStack {
                ForEach(HomeType.allCases, id: \.self) { type in
                    Button {
                        selectedTab = type
                    } label: {
                        Text(type.rawValue)
                            .font(.semiBold24)
                            .foregroundColor(selectedTab == type ? .black : .gray04)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 8)
    }
    
    var movieView: some View {
        VStack {
            //TODO: 선택 탭 바뀌게
            HStack(spacing: 16) {
                Button {
                    
                } label: {
                    Text("무비차트")
                        .font(.medium14)
                        .tint(.white)
                        .padding(8)
                        .background(
                            Capsule()
                                .foregroundStyle(.gray08)
                                .glassEffect()
                        )
                }
                Button {
                    
                } label: {
                    Text("상영예정")
                        .font(.medium14)
                        .tint(.gray04)
                        .padding(8)
                        .background(
                            Capsule()
                                .foregroundStyle(.gray02)
                                .glassEffect()
                        )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            //MARK: - Movie Posters
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(vm.posterList) { poster in
                        MoviePoster(movie: poster)
                            .padding(.vertical, 4)
                    }
                }
            }
            
            //MARK: - MovieFeedView
            VStack {
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("알고보면 더 재미있는 무비 피트")
                            .font(.bold24)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.semiBold16)
                    }
                    .tint(.black)
                }
                .padding(.top, 20)
                Image(.movieFeedTitle)
                    .resizable()
                
                ForEach(vm.feedList) { feed in
                    MovieFeedView(movie: feed)
                }
            }
            
        }
    }
    
    
}

#Preview {
    HomeView()
}
