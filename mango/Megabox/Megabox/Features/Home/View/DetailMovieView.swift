//
//  DetailMovieView.swift
//  Megabox
//
//  Created by 송민교 on 10/5/25.
//

import SwiftUI
import Kingfisher

struct DetailMovieView: View{
    // 상위뷰로부터
    let movie: MovieModel
    @Environment(NavigationRouterViewModel.self) private var router
    
    @State var bottomButton = "detailInfo"
    
    var body: some View{
        @Bindable var router = router
        
        ScrollView(showsIndicators: false){
            VStack{
                KFImage(URL(string: movie.topPosterImageName))
                    .placeholder{
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 441, height: 218)
                    .clipped()
                
                Text(movie.movieTitle)
                    .font(.pretend(type: .bold, size: 24))
                Text(movie.originalTitle)
                    .font(.pretend(type: .semibold, size: 14))
                    .foregroundStyle(Color.gray03)
                Text("\(movie.tagline)\n")
                    .font(.pretend(type: .semibold, size: 18))
                    .foregroundStyle(Color.gray03)
                    .frame(width: 409, alignment: .center)
                Text(movie.synopsis)
                    .font(.pretend(type: .semibold, size: 18))
                    .foregroundStyle(Color.gray03)
                    .frame(width: 409, alignment: .center)
                
                BottomSection
            }
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text(movie.movieTitle)
                        .font(.pretend(type: .semibold, size: 17))
                }
                ToolbarItem(placement: .topBarLeading){
                    Button(action:{
                        router.pop()
                    }){
                        Image(systemName: "arrow.left")
                            .foregroundStyle(Color.black)
                    }
                }
            }
        }
    }
    var BottomSection: some View{
        VStack{
            HStack(spacing:0){
                Button(action:{
                    bottomButton = "detailInfo"
                }){
                    Text("상세정보")
                        .font(.pretend(type: .bold, size: 22))
                        .foregroundStyle(bottomButton=="detailInfo" ? Color.black : Color.gray02)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(bottomButton=="detailInfo" ? Color.black : Color.gray02)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                )
                
                Button(action:{
                    bottomButton = "reviewInfo"
                }){
                    Text("실관람평")
                        .font(.pretend(type: .bold, size: 22))
                        .foregroundStyle(bottomButton=="reviewInfo" ? Color.black : Color.gray02)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(bottomButton=="reviewInfo" ? Color.black : Color.gray02)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                )
            }
            
            if bottomButton == "detailInfo"{
                VStack{
                    DetailInfoView
                }
                .padding(.horizontal, 30)
            }
            else{
                ReviewInfoView
            }
        }
    }
    
    var DetailInfoView: some View{
        HStack(alignment: .top){
            KFImage(URL(string: movie.movieImageName))
                .placeholder{
                    ProgressView()
                        .frame(width: 150, height: 218)
                        .background(Color.gray01)
                }.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 120)
                .clipped()
            VStack(alignment: .leading, spacing: 10){
                Text(movie.rating)
                    .font(.pretend(type: .semibold, size: 13))
                Text(movie.releaseDate)
                    .font(.pretend(type: .semibold, size: 13))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var ReviewInfoView: some View{
        VStack{
            Text("등록된 관람평이 없어요🥲")
                .font(.pretend(type: .semibold, size: 18))
                .padding(.horizontal, 97)
                .padding(.vertical, 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple03, lineWidth: 1)
                )
            Spacer()
        }
    }
}
