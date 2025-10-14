//
//  MovieSearchViewModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/14/25.
//

import Foundation
import Combine

class MovieSearchViewModel: ObservableObject {
    
    private let model : [MovieModel] = [
        .init(name:"어쩔수가 없다", imageName: "djWjftnrk", audience:"20만", age:15),
        .init(name:"극장판 귀멸의 칼날", imageName:"infinityCastle", audience:"60만",age:15),
        .init(name:"F1: 더 무비", imageName: "f1" , audience:"10만",age:12),
        .init(name:"보스", imageName: "boss" , audience:"30만",age:15),
        .init(name:"모노노케 히메", imageName: "mononoke" , audience:"40만",age:12),
        .init(name:"야당", imageName: "yaDang" , audience:"50만",age:18),
        .init(name:"얼굴", imageName: "face" , audience:"70만",age:12),
        .init(name:"the Roses", imageName: "theRoses" , audience:"80만",age:15)
    ]
    
    @Published var query: String = ""
    @Published var results: [MovieModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var bag = Set<AnyCancellable>()
    
    
    init() {
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
            })
            .flatMap { query in
                self.search(query: query)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let err) = completion {
                    self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                    self?.results = []
                }
            } receiveValue: { [weak self] items in
                self?.results = items
            }
            .store(in: &bag)
    }

    private func search(query: String) -> AnyPublisher<[MovieModel], Error> {
        
        return Future<[MovieModel], Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            guard let self else { return }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let filtered: [MovieModel]
                    if query.isEmpty {
                        filtered = self.model  // 전체 영화
                    } else {
                        filtered = self.model.filter { $0.name.lowercased().contains(query.lowercased()) }
                    }
                    promise(.success(filtered))
                }
            }
            .handleEvents(
                receiveSubscription: { _ in
                    DispatchQueue.main.async {
                        self.isLoading = true
                    }
                },
                receiveCompletion: { _ in
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            )
            .eraseToAnyPublisher()
    }
}
