//
//  HomeView.swift
//  Megabox
//
//  Created by 송민교 on 10/4/25.
//

import SwiftUI

struct RootView: View {
    @State private var homeRouter = NavigationRouterViewModel()
    @State private var reservationRouter = NavigationRouterViewModel()
    @State private var mobileOrderRouter = NavigationRouterViewModel()
    @State private var profileRouter = NavigationRouterViewModel()
    @State private var viewModel = MovieViewModel()

    var body: some View {
        TabView {
            //홈 탭
            
            HomeView(viewModel: viewModel, router: $homeRouter)
                .tabItem { Label("홈", systemImage: "house") }

            // 바로 예매 탭
            ReservationView()
                .tabItem { Label("바로예매", systemImage: "ticket") }

            // 모바일오더 탭
            MobileOrderView()
                .tabItem { Label("모바일오더", systemImage: "popcorn") }

            // 마이페이지 탭
            ProfileView()
                .tabItem { Label("마이페이지", systemImage: "person") }
        }
    }
}

struct HomeView: View {
    let viewModel: MovieViewModel
    @Binding var router: NavigationRouterViewModel
    
    @State private var selectedTab = "홈"
    @State private var selectedButton = "movieChart"
    
    // movieFeedSection
    private let item = MovieFeedItemViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView(showsIndicators: true) {
                VStack(alignment: .leading) {
                    headerSection
                    movieCardSection
                    movieFeedSection
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let movie):
                    DetailMovieView(movie: movie, router: $router)
                }
            }
        }
    }
    var headerSection: some View {
        VStack(alignment: .leading) {
            Image("meboxHomeLogo")
            HStack {
                topTabButton("홈")
                Spacer()
                topTabButton("이벤트")
                Spacer()
                topTabButton("스토어")
                Spacer()
                topTabButton("선호극장")
            }
            .frame(width: 320)
        }
    }
    
    func topTabButton(_ title: String) -> some View {
        Button(action: {
            selectedTab = title
        }) {
            Text(title)
                .font(.pretend(type: .semibold, size: 24))
                .foregroundStyle(selectedTab == title ? Color.black : Color.gray04)
        }
    }
    
    @ViewBuilder
    var movieCardSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    selectedButton = "movieChart"
                }) {
                    Text("무비차트")
                        .font(.pretend(type: .medium, size: 14))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                }
                .tint(.gray08)
                .buttonStyle(.borderedProminent)
                
                Button(action: {
                    selectedButton = "comingSoon"
                }) {
                    Text("상영예정")
                        .foregroundStyle(Color.gray04)
                        .font(.pretend(type: .medium, size: 14))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                }
                .buttonStyle(.bordered)
                .tint(.gray02)
            }
            .padding(.vertical, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 24) {
                    ForEach(currentMovieList) { movie in
                        MovieCard(movie: movie, router: $router)
                    }
                }
            }
        }
    }
    
    private var currentMovieList: [MovieModel] {
        selectedButton == "movieChart" ? viewModel.movieChartList : viewModel.comingSoonList
    }
    
    var movieFeedSection: some View {
        VStack {
            HStack {
                Text("알고 보면 더 재밌는 무비피드")
                    .font(.pretend(type: .bold, size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {}) {
                    Image(systemName: "arrow.right")
                        .foregroundStyle(Color.gray08)
                }
            }
            
            Image("movieFeed")
                .resizable()
            
            VStack(alignment:.leading){
                ForEach(item.feedList){ item in
                    HStack(spacing: 20){
                        Image(item.thumbnailName)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                        VStack(alignment: .leading){
                            Text(item.title)
                                .font(.pretend(type: .semibold, size: 18))
                            Spacer()
                            Text(item.subtitle)
                                .foregroundStyle(Color.gray03)
                                .font(.pretend(type: .semibold, size: 13))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                }
            }
            
        }
        .padding(.top, 20)
    }
}

#Preview {
    RootView()
}
