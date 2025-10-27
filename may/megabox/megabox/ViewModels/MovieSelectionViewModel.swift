//
//  MovieSelectionViewModel.swift
//  megabox
//
//  Created by 백지은 on 10/11/25.
//

import SwiftUI
import Combine

final class MovieSelectionViewModel: ObservableObject {
    @Published var allMovies: [MovieBooking] = []
    @Published var filteredMovies: [MovieBooking] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMovies()
        
        $searchText
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { [weak self] text in
                self?.filterMovies(by: text) ?? []
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                self?.filteredMovies = movies
            }
            .store(in: &cancellables)
    }
    
    private func loadMovies() {
        // 더미데이터?
        self.allMovies = [
            MovieBooking(posterImage: Image(.movie1), title: "어쩔수가없다", ageRating: "15"),
            MovieBooking(posterImage: Image(.movie2), title: "극장판 귀멸의 칼날: 무한성 편", ageRating: "15"),
            MovieBooking(posterImage: Image(.movie3), title: "F1: 더 무비", ageRating: "15"),
            MovieBooking(posterImage: Image(.movie4), title: "얼굴", ageRating: "15"),
            MovieBooking(posterImage: Image(.movie5), title: "모노노케 히메", ageRating: "ALL"),
            MovieBooking(posterImage: Image(.movie6), title: "야당", ageRating: "15"),
            MovieBooking(posterImage: Image(.movie7), title: "보스", ageRating: "15"),
            MovieBooking(posterImage: Image(.movie8), title: "THE ROSES", ageRating: "15")
        ]
        self.filteredMovies = allMovies
    }
    
    private func filterMovies(by keyword: String) -> [MovieBooking] {
        guard !keyword.isEmpty else { return allMovies }
        return allMovies.filter { $0.title.contains(keyword) }
    }
}
