//
//  MoviewView.swift
//  Week_Practice
//
//  Created by 송민교 on 9/27/25.
//

import SwiftUI

struct MovieView:View{
    private var viewModel = MovieViewModel()
    @AppStorage("movieName") private var selectedMovie: String = ""
    
    var body: some View{
        VStack(spacing:50){
            
            MovieCard(movieInfo: viewModel.movieModel[viewModel.currentIndex])
            
            headerButton
            
            movieSelectButton
            
            selectedMovieText
        }
        .padding()
    }
    
    private var headerButton: some View{
        HStack(spacing:61){
            
            Button(action:{
                viewModel.previousMovie()
            }){
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 18, height: 30)
                    .foregroundStyle(Color.black)
            }
            
            Text("영화 바꾸기")
                .font(.system(size: 20))
            
            Button(action:{
                viewModel.nextMovie()
            }){
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 18, height: 30)
                    .foregroundStyle(Color.black)
            }
        }
        .padding(.vertical, 17)
        .padding(.horizontal, 22)
    }
    
    private var movieSelectButton: some View{
        Button(action:{
            selectedMovie = viewModel.movieModel[viewModel.currentIndex].movieName
        }){
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 246, height: 65)
                
                Text("대표 영화로 설정")
                    .foregroundStyle(Color.black)
            }
        }
    }
    
    private var selectedMovieText: some View{
        VStack(spacing:17){
            Text("@AppStorage에 저장된 영화")
                .font(.system(size: 30))
            
            Text("현재 저장된 영화: \(selectedMovie)")
                .foregroundStyle(Color.red)
        }
    }
}


#Preview{
    MovieView()
}
