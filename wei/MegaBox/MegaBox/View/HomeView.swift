//
//  HomeView.swift
//  MegaBox
//
//  Created by 이연우 on 10/6/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @State var viewModel: MovieViewModel = .init()
    @Binding var path: NavigationPath
    
    var body: some View {
        ScrollView {
            LazyVStack {
                TopBar
                if viewModel.isLoading {
                    ProgressView("영화 정보를 불러오는 중...")
                        .padding(.vertical, 100)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text("오류가 발생했습니다")
                            .font(.bold18)
                        Text(errorMessage)
                            .font(.medium14)
                            .foregroundColor(.gray03)
                        Button("다시 시도") {
                            Task {
                                await viewModel.fetchNowPlayingMovies()
                            }
                        }
                        .padding()
                        .background(Color.purple03)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding(.vertical, 100)
                } else {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 16) {
                            ForEach(viewModel.movies) { movie in
                                MovieCard(movie)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 25)
                    }
                    
                }
                BottomInfo
            }
        }
        .task {
            await viewModel.fetchNowPlayingMovies()
        }
        .navigationDestination(for: MovieModel.self) { movie in
                    MovieInfoView(movie: movie)
        }
    }
    

    
    
    private var TopBar: some View {
        VStack(spacing:10){
            Image(.meboxLogo1)
                .resizable()
                .frame(width: 149, height: 34)
                .padding(.trailing, 200)
            
            HStack(spacing:31){
                Text("홈")
                    .font(.semiBold24)
                    .foregroundColor(.black)
                Text("이벤트")
                    .font(.semiBold24)
                    .foregroundColor(.gray04)
                Text("스토어")
                    .font(.semiBold24)
                    .foregroundColor(.gray04)
                Text("선호극장")
                    .font(.semiBold24)
                    .foregroundColor(.gray04)
            }
            .padding(.trailing, 30)
            
            HStack(spacing:23){
                Button(action:{
                    
                },label:{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(Color.gray08)
                        .overlay(
                            Text("무비차트")
                                .font(.medium14)
                                .foregroundStyle(Color.white)
                        )
                        .frame(width: 84, height: 38)
                })
                
                Button(action:{
                    
                },label:{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(Color.gray02)
                        .overlay(
                            Text("상영예정")
                                .font(.medium14)
                                .foregroundStyle(Color.gray04)
                        )
                        .frame(width: 84, height: 38)
                })
            }
            .padding(.trailing, 180)
            
        }
        
    }
    
    private func MovieCard(_ movie: MovieModel) -> some View {
        VStack(alignment: .leading ,spacing: 8) {
            Button(action:{
                path.append(movie)
            },label:{
                KFImage(URL(string: movie.imageName))
                    .placeholder {
                        Rectangle()
                            .fill(Color.gray02)
                            .frame(width: 148, height: 200)
                            .overlay(
                                ProgressView()
                            )
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width:148, height:200)
                    .clipped()
                    .cornerRadius(8)
            })
            
            
            Button(action: {
                
            }, label: {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.purple03, lineWidth: 1)
                    .frame(width: 150, height: 40)
                    .overlay(
                        Text("바로 예매")
                            .foregroundColor(.purple03)
                            .font(.medium16)
                    )
            })
            
            Text(movie.name)
                .font(.bold22)
                .foregroundColor(.black)
                .frame(width: 150, height: 24, alignment: .leading) 
                    .clipped()
            
                
            
            Text("누적관객수 \(movie.audience)")
                .font(.medium18)
                .foregroundColor(.black)
            
            
        }
        
        
    }
    
    private var BottomInfo: some View {
        VStack{
            HStack(spacing:88){
                Text("알고보면 더 재밌는 무비피드")
                    .font(.bold24)
                    .foregroundColor(Color.black)
                
                Button(action:{
                    
                },label:{
                    Image(systemName: "arrow.right")
                        .foregroundStyle(Color.black)
                })
            }
            
            VStack(spacing:39){
                Image(.movie)
                    .resizable()
                    .frame(width:380, height: 200)
                
                VStack(alignment: .leading, spacing:39){
                    HStack(spacing:20){
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.clear)
                            .frame(width: 100, height: 100)
                            .background(
                                Image(.movieImage2)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100))
                        VStack(alignment: .leading,spacing:25){
                            Text("9월, 메가박스의 영화들(1) - 명작들의 재개봉’")
                                .font(.semiBold18)
                                .foregroundStyle(Color.black)
                            Text("<모노노케 히메>,<퍼펙트 블루>")
                                .font(.semiBold13)
                                .foregroundStyle(Color.gray03)
                        }
                    }
                    HStack(spacing:20){
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.clear)
                            .frame(width: 100, height: 100)
                            .background(
                                Image(.movieImage3)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100))
                        VStack(alignment: .leading,spacing:25){
                            Text("메가박스 오리지널 티켓 Re.37 <얼굴>")
                                .font(.semiBold18)
                                .foregroundStyle(Color.black)
                            Text("영화 속 양극적인 감정의 대비")
                                .font(.semiBold13)
                                .foregroundStyle(Color.gray03)
                        }
                    }

                }
                
                                
            }
        }
        .padding(.horizontal,8)
        
    }
}

//#Preview {
//    HomeView()
//}

