//
//  MoviewSearchViewModel.swift
//  Megabox
//
//  Created by 송민교 on 10/28/25.
//

import SwiftUI
import Combine

final class MovieSearchViewModel: ObservableObject {
    private var model:[MovieSelectModel] = [
        .init(movieImageName: "f1", title: "F1", isSelected: false),
        .init(movieImageName: "movie3", title: "주술회전", isSelected: false),
        .init(movieImageName: "movie5", title: "어쩔수가없다", isSelected: false),
        .init(movieImageName: "face", title: "얼굴", isSelected: false),
        .init(movieImageName: "mononoke", title: "모노노케 히메", isSelected: false),
        .init(movieImageName: "boss", title: "보스", isSelected: false)
    ]
    
    var displayedMovies: [MovieSelectModel] {
        results.isEmpty ? model : results
    }
    
    // 검색
    @Published var query: String = ""
    // 결과 저장
    @Published private(set) var results: [MovieSelectModel] = []
    // 로딩
    @Published private(set)var isLoading: Bool = false
    // 에러
    @Published private(set)var errorMessage: String? = nil
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        $query
            // 400ms 동안 디바이스
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            // 중복값에는 반응 x
            .removeDuplicates()
            .handleEvents(receiveOutput: {[weak self] _ in
                self?.errorMessage = nil
            })
            .flatMap {query in
                self.search(query: query)
            }
            // UI 업데이트는 메인 스레드에서
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                if case.failure(let err) = completion {
                    self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                    self?.results = []
                    }
                } receiveValue: {[weak self] items in
                    self?.results = items
                }
                .store(in: &bag)
    }
    
    private func search(query: String) -> AnyPublisher<[MovieSelectModel], Error> {
        return Future<[MovieSelectModel],Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...3000))/1000.0
            guard let self else {return}
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay){
                let filtered = self.model.filter { $0.title.lowercased().contains(query)}
                promise(.success(filtered))
            }
        }
        .handleEvents(
            // 구독시작 시
            receiveSubscription: { _ in
                DispatchQueue.main.async{
                    self.isLoading = true
                }
            },
            // 완료 시
            receiveCompletion: { _ in
                DispatchQueue.main.async{
                    self.isLoading = false
                }
            }
        )
        .eraseToAnyPublisher()
    }
}
