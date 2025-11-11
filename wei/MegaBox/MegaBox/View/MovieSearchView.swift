//
//  MovieSearchView.swift
//  MegaBox
//
//  Created by 이연우 on 10/13/25.
//

import Foundation
import SwiftUI
import Combine

struct MovieSearchView: View {
    @StateObject private var vm = MovieSearchViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
        

            if vm.isLoading {
                ProgressView("검색중…")
            }

            if let error = vm.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(vm.results) { movie in
                        MovieCard(movie: movie)
                    }
                }
                .padding(.horizontal, 20)
            }
            
            TextField("Search", text: $vm.query)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.regular18)
                .padding(.horizontal, 20)
        }
        .navigationTitle("영화 선택")
    }
    
    private func MovieCard(movie: MovieModel) -> some View {
        VStack(spacing: 8) {
            Image(movie.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 140)
                .clipped()
            
            Text(movie.name)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(height: 32)
        }
    }
}
