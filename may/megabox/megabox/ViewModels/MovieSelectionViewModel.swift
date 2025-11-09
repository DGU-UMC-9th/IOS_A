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
        setupSearchBinding()
        loadMovies()
    }
    
    private func setupSearchBinding() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
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
        isLoading = true
        errorMessage = nil
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            do {
                guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") else {
                    throw MovieLoadError.fileNotFound
                }
                
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder.movieScheduleDecoder
                let apiResponse = try decoder.decode(ApiResponse.self, from: data)
                
                guard let movieDTOs = apiResponse.data?.movies else {
                    throw MovieLoadError.emptyData
                }
                
                let domainMovies = movieDTOs.map { $0.toDomain() }
                
                DispatchQueue.main.async {
                    self.allMovies = domainMovies
                    self.filteredMovies = domainMovies
                    self.isLoading = false
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "영화 목록을 불러올 수 없습니다."
                    self.isLoading = false
                    print("MovieSelectionView 로드 에러: \(error)")
                }
            }
        }
    }
    
    private func filterMovies(by keyword: String) -> [MovieBooking] {
        guard !keyword.isEmpty else { return allMovies }
        return allMovies.filter { $0.title.localizedCaseInsensitiveContains(keyword) }
    }
}
