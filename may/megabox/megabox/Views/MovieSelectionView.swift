//
//  MovieSelectionView.swift
//  megabox
//
//  Created by 백지은 on 10/11/25.
//

import SwiftUI

struct MovieSelectionView: View {
    @StateObject private var viewModel = MovieSelectionViewModel()
    
    var onSelect: (MovieBooking) -> Void
        @Environment(\.dismiss) private var dismiss
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("영화 선택")
                .font(.semiBold18)
                .padding(.vertical, 15)
            
            if viewModel.isLoading {
                ProgressView("영화 목록을 불러오는 중...")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 36) {
                        ForEach(viewModel.filteredMovies) { movie in
                            VStack {
                                movie.posterImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 95, height: 135)
                                Text(movie.title)
                                    .font(.semiBold14)
                                    .lineLimit(1)
                            }
                            .onTapGesture {
                                onSelect(movie)
                                dismiss()
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("영화 제목을 입력해주세요", text: $viewModel.searchText)
                    .padding(10)

                if !viewModel.searchText.isEmpty {
                    Button(action: { viewModel.searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
            }
            .padding(.horizontal)
            .background(Color(.gray01))
            .cornerRadius(10)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    MovieSelectionView { movie in
        print("선택한 영화: \(movie.title)")
    }
}
