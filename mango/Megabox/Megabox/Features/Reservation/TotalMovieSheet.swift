//
//  TotalMovieView.swift
//  Megabox
//
//  Created by 송민교 on 10/28/25.
//

import SwiftUI

struct TotalMovieSheet: View{
    @StateObject private var movie = MovieSearchViewModel()
    var body: some View {
        VStack{
            Text("영화 선택")
                .padding()
            
            List(movie.displayedMovies, id:\.id) { movie in
                HStack{
                    Image(movie.movieImageName)
                        .resizable()
                        .frame(width: 95, height: 135)
                    Text(movie.title)
                }
            }
            if movie.isLoading{
                ProgressView("검색중이애요")
            }
            
            if let error = movie.errorMessage{
                Text(error).foregroundStyle(.red)
            }
            
        }
        GlassEffectContainer{
            HStack(spacing:10){
                HStack{
                    Image(systemName: "magnifyingglass")
                    
                    TextField("영화명을 입력해주세요", text: $movie.query)
                    
                    Button(action:{}){
                        Image(systemName: "mic")
                            .foregroundStyle(Color.gray03)
                    }
                }
                .padding()
                .glassEffect()
                
                Button(action:{}){
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.black)
                }
                .frame(width: 16, height: .infinity)
                .padding()
                .clipShape(Capsule())
                .glassEffect()
            }
            .frame(maxWidth: .infinity)
            
        }
        .padding(.horizontal, 26)
        .frame(width: 440)
    }
}

#Preview {
    TotalMovieSheet()
}
