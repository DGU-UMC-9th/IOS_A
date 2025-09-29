//
//  MovieView.swift
//  Week2_Practice
//
//  Created by 이연우 on 9/29/25.
//

import Foundation
import SwiftUI
import Observation

struct MovieView : View {
    
    @AppStorage("movieName") private var movieName: String = ""
    private var viewModel: MovieViewModel = .init()
    
    var body: some View {
        VStack(spacing: 56) {
            
            MovieCard(movieInfo: viewModel.movieModel[viewModel.currentIndex])
            
            MovieChange
            
            SettingMovie
            
            AppStorageValue
        }
        
    }
    
    private var MovieChange: some View {
        HStack {
            Group {
                Button(action:{
                    viewModel.previousMovie()
                }, label : {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 17.47, height: 29.73)
                })
                
                Spacer()
                
                
                Text("영화바꾸기")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.black)
                
                Spacer()
                
                Button(action:{
                    viewModel.nextMovie()
                }, label : {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 17.47, height: 29.73)
                })
                
                
            }
            .foregroundStyle(Color.black)
        }
        .frame(width: 256)
        .padding(.horizontal,22)
        .padding(.vertical, 17)
    }
    
    private var SettingMovie: some View {
        
        Button(action:{
            self.movieName = viewModel.movieModel[viewModel.currentIndex].movieName
        }, label:{
            Text("대표 영화로 설정")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(Color.black)
                .padding(.top, 21)
                .padding(.bottom, 20)
                .padding(.leading, 53)
                .padding(.trailing, 52)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                        .stroke(Color.black, style: .init(lineWidth: 1))
                })
        })
    }
    
    private var AppStorageValue : some View {
        VStack(spacing: 17) {
                    Text("@AppStorage에 저장된 영화")
                        .font(.system(size: 30, weight: .regular))
                        .foregroundStyle(Color.black)
                    
                    Text("현재 저장된 영화 : \(movieName)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(Color.red)
                }
    }
    
}

#Preview {
    MovieView()
}
