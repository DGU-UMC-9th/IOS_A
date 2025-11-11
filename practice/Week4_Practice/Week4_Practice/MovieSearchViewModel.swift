//
//  MovieSearchViewModel.swift
//  Week4_Practice
//
//  Created by 이연우 on 10/12/25.
//

import Foundation
import SwiftUI
import Combine

class MovieSearchViewModel : ObservableObject {
    private let  model : [MovieModel] = [
        .init(movieImage: .init(.mickey), title: "미키", rate: 9.1),
        .init(movieImage: .init(.toystory), title: "토이스토리", rate: 8.2),
        .init(movieImage: .init(.brutalis), title: "브루탈리스트", rate: 8.2),
        .init(movieImage: .init(.snowWhite), title: "백설공주", rate: 8.2),
        .init(movieImage: .init(.whiplash), title: "위플래시", rate: 8.2),
        .init(movieImage: .init(.conclave), title: "콘클라베", rate: 8.2),
        .init(movieImage: .init(.theFall), title: "더폴", rate: 8.2)
    ]
    
    @Published var query: String = "" //검색
    @Published var results: [MovieModel] = [] //결과 저장
    @Published var isLoading = false //로딩 처리
    @Published var errorMessage: String? // 에러 메세지

    private var bag = Set<AnyCancellable>() // 구독 유지
    
    
    init() {
        $query //사용자가 타이핑 할 때마다 이벤트 나옴
            .debounce(for: .milliseconds(350), scheduler: DispatchQueue.main) // 타이핑이 멈춘 뒤 0.35초 후에만 다음 단계로
            .removeDuplicates() //이전과 같은 문자열이면 무시(예: 같은 글자 왔다 갔다 할 때 중복 호출 방지).
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
            })
        //hadleEvents : 중간 감시자 역할의 Operator, 실제 검색 전에 에러 메세지 초기화
            .flatMap { query in
                self.search(query: query) //여기서 비교 시작!!!!!!(백그라운드에서 실행됨)
            }
            .receive(on: DispatchQueue.main) // 이후 구독자가 main스레드에서 동작하도록 강제
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
    
    //실패해도 앱이 멈추지 않게 Never 타입 명시
    private func search(query: String) -> AnyPublisher<[MovieModel], Error> {
        //Future: 비동기 작업을 1번만 내보내는 Publisher
        return Future<[MovieModel], Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            guard let self else { return }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) { //지금으로부터 delay초 뒤에
                let filtered = self.model.filter { $0.title.lowercased().contains(query) } // 작업을 비동기로 실행
                promise(.success(filtered)) //Future가 약속한 단 한 번의 결과를 전달
                //성공 시 .success(value) 실패 시 .failure(error)
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
