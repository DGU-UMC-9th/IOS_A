//
//  HomeView.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selected: HomeCategory = .home
    @State var model: HomeViewModel
    
    @State private var selectedTab: MovieTab = .chart
    
    init(model: HomeViewModel = HomeViewModel()) {
        _model = State(initialValue: model)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HeaderSection
                Group {
                    switch selected {
                    case .home:
                        ButtonSection(selectedTab: $selectedTab)
                        ContentSection
                    case .event:
                        basicSection
                    case .store:
                        basicSection
                    case .prefer:
                        basicSection
                    }
                }
            }
        }
        .task {
            await model.fetchNowPlayingMovies()
        }
    }
    
    private var HeaderSection: some View {
        VStack(alignment: .leading) {
            Image(.meboxHeader)
            HStack(spacing: 31) {
                ForEach(HomeCategory.allCases, id: \.self) { type in
                    Button {
                        selected = type
                    } label: {
                        Text(type.getName)
                            .font(.semiBold24)
                            .foregroundColor(selected == type ? .black : .gray04)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
        .padding(.top, 5)
    }
    
    private var ContentSection: some View {
        Group {
            if selectedTab == .chart {
                VStack(spacing: 40){
                    if model.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .padding()
                    } else if let errorMessage = model.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        MovieChartView(chartList: model.chartList)
                        MovieFeedView(feedList: model.feedList)
                    }
                }
                .padding(.top, 10)
            } else if selectedTab == .comingSoon {
                Text("상영예정 화면")
            }
        }
        .padding(.top, 5)
    }
    
    private var basicSection : some View {
        Text("아직 구현 X")
    }
}

private struct ButtonSection: View {
    @Binding var selectedTab: MovieTab
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(MovieTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    Text(tab.title)
                        .font(.medium14)
                        .foregroundStyle(selectedTab == tab ? Color.white : Color.gray04)
                        .frame(width: 84, height: 38)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(selectedTab == tab ? Color.gray08 : Color.gray02)
                        )
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 3)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview{
    let previewViewModel = HomeViewModel()
    return HomeView(model: previewViewModel)
}
