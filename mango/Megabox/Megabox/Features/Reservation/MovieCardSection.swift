//
//  MovieCardSection.swift
//  Megabox
//
//  Created by 송민교 on 10/13/25.
//

import SwiftUI

struct movieCardSection: View{
    @ObservedObject var movieViewModel: MovieSelectViewModel
    @State private var isSheetShow = false
    
    var body: some View {VStack{
        // moviCard 헤더부분
        HStack{
            HStack{
                if let selectedMovie = movieViewModel.selectedMovie{
                    Text("15")
                        .font(.pretend(type: .bold, size: 18))
                        .foregroundStyle(Color.white)
                        .padding(3)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(red:1, green: 0.5, blue: 0))
                            
                        )
                    Text(selectedMovie.title)
                        .font(.pretend(type: .bold, size: 18))
                        .frame(alignment: .topLeading)
                }
            }
            
            Spacer()
            
            Button(action: {
                isSheetShow = true
            }){
                Text("전체영화")
                    .padding(10)
                    .font(.pretend(type: .semibold, size: 14))
                    .foregroundStyle(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray02, lineWidth: 1)
                    )
            }
        }
        .padding(.bottom, 10)
        
        // movieCard movieImage 부분
        ScrollView(.horizontal){
            HStack(alignment: .top, spacing:8){
                ForEach(movieViewModel.movies){ movie in
                    Image(movie.movieImageName)
                        .resizable()
                        .frame(width: 62, height: 89)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            movieViewModel.selectedMovie = movie
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, alignment: .top)
    }
    .padding(.horizontal, 10)
    .sheet(isPresented: $isSheetShow){
        TotalMovieSheet()
        }
    }
}
