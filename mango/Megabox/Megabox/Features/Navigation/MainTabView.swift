//
//  TabView.swift
//  Megabox
//
//  Created by 송민교 on 10/9/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var viewModel = MovieViewModel()
    @Environment(NavigationRouterViewModel.self) private var router

    @StateObject private var movieSelectVM: MovieSelectViewModel
    @StateObject private var calendarVM: CalendarViewModel
    @StateObject private var theaterInfoVM: TheaterInfoViewModel

    init() {
        let m = MovieSelectViewModel()
        _movieSelectVM = StateObject(wrappedValue: m)
        _calendarVM = StateObject(wrappedValue: CalendarViewModel())
        _theaterInfoVM = StateObject(wrappedValue: TheaterInfoViewModel(movieVM: m))
    }

    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.path){
            TabView {
                //홈 탭
                Tab("홈", systemImage: "house"){
                    HomeView(viewModel: viewModel)
                }

                // 바로 예매 탭
                Tab("바로예매", systemImage: "ticket"){
                    ReservationView(movieViewModel: movieSelectVM,
                                    calendarViewModel: calendarVM,
                                    theaterInfoViewModel: theaterInfoVM)
                }

                // 모바일오더 탭
                Tab("모바일오더", systemImage: "popcorn"){
                    MobileOrderView()
                }

                // 마이페이지 탭
                Tab("마이페이지", systemImage: "person"){
                    ProfileView()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let movie):
                    DetailMovieView(movie: movie)
                case .detailOrder:
                    MobileOrderDetailView()
                }
            }
        }
       
    }
}
