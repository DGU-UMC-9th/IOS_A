//
//  MovieView.swift
//  megabox
//
//  Created by 백지은 on 9/27/25.
//

import SwiftUI
import Observation

struct MovieView: View {
    @AppStorage("movieName") private var movieName: String = ""
        private var viewModel: MovieViewModel = .init()
    
    var body: some View {
        VStack(spacing: 56) {
            MovieCard(movieInfo: viewModel.movieModel[viewModel.currentIndex])
            
            moveButton
            
            settingMovie
            
            printAppStorageValue
        }
        .padding()
    }
    
    /// 좌우 영화 바꾸기 버튼
    private var moveButton : some View {
        HStack{
            Group{
                makeChevron(name: "chevron.left", action: viewModel.previousMovie)
                        
                Spacer()
                        
                Text("영화 바꾸기")
                    .font(.regular20)
                        
                Spacer()
                        
                makeChevron(name: "chevron.right", action: viewModel.nextMovie)
            }
            .foregroundStyle(Color.black)
        }
        .frame(width: 256, height: 20)
        .padding(.vertical, 17)
        .padding(.horizontal, 22)
    }
            
    private func makeChevron(name: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: name)
                .resizable()
                .frame(width: 17.467, height: 29.733)
        })
    }
            
    /// 대표 영화 설정
    private var settingMovie: some View {
        Button(action: {
            self.movieName = viewModel.movieModel[viewModel.currentIndex].movieName
        }, label: {
            Text("대표 영화로 설정")
                .font(.regular20)
                .foregroundStyle(Color.black)
                .padding(.top, 21)
                .padding(.bottom, 20)
                .padding(.leading, 53)
                .padding(.trailing, 52)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                        .stroke(Color.black, style:
                                .init(lineWidth: 1))
                })
        })
    }
            
    /// 하단 AppStorage에 저장된 영화 확인 텍스트
    private var printAppStorageValue: some View {
        VStack(spacing: 17) {
            Text("@AppStorage에 저장된 영화")
                .font(.semiBold24)
                .foregroundStyle(Color.black)
            
            Text("현재 저장된 영화 : \(movieName)")
                .font(.regular20)
                .foregroundStyle(Color.red)
        }
    }
}

#Preview {
    MovieView()
}
