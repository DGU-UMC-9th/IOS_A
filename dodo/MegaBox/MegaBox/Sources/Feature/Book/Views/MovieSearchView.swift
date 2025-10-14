//
//  MovieSearchView.swift
//  MegaBox
//
//  Created by 김도연 on 10/13/25.
//


import SwiftUI
import Combine

struct MovieSearchView: View {
    @StateObject private var vm = BookingViewModel()
    @Environment(\.dismiss) var dismiss
    var onSelect: (Movie) -> Void

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                if let error = vm.errorMessage {
                    Text(error).foregroundStyle(.red)
                } else if vm.isLoading {
                    ProgressView("검색중…")
                } else if vm.results.isEmpty {
                    Text("검색 결과가 없습니다.")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 36) {
                            ForEach(vm.results) { movie in
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
                
                
            }
            .searchable(text: $vm.query, placement: .automatic, prompt: "영화명을 입력해주세요")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("영화 선택")
                        .font(.bold18)
                }
            }
        }
    }
}

#Preview {
    MovieSearchView{ movie in
        print(movie)
    }
}
