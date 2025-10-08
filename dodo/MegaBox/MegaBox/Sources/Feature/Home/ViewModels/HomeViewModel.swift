//
//  HomeViewModel.swift
//  MegaBox
//
//  Created by 김도연 on 9/29/25.
//

import SwiftUI
import Observation

@Observable
class HomeViewModel {
    var posterList: [MovieModel] = [
        MovieModel(
            posterImage: Image(.poster1),
            title: "어쩔수가없다",
            audienceCount: "20만"
        ),
        MovieModel(
            posterImage: Image(.poster2),
            title: "극장판 귀멸의 칼날: 무한성 편",
            audienceCount: "10만"
        ),
        MovieModel(
            posterImage: Image(.poster3),
            title: "F1: 더 무비",
            audienceCount: "1만"
        ),
        MovieModel(
            posterImage: Image(.poster4),
            title: "얼굴",
            audienceCount: "0.5만"
        ),
        MovieModel(
            posterImage: Image(.poster5),
            title: "모노노케 히메",
            audienceCount: "0.3만"
        )
    ]
    
    var feedList: [MovieFeed] = [
        MovieFeed(title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉", description: "<모노노케 히메>,<퍼펙트 블루>", posterImage: Image(.movieFeed1)),
        MovieFeed(title: "메가박스 오리지널 티켓 Re.37 <얼굴>", description: "영화 속 양극적인 감정의 대비", posterImage: Image(.movieFeed2))
    ]
}
