//
//  HomeViewModel.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI
import Observation

@Observable
class HomeViewModel{
    var chartList: [MovieModel] = [
        MovieModel(
            posterImage: Image(.movie1),
            title: "어쩔수가없다",
            audienceCnt: "20만"
        ),
        MovieModel(
            posterImage: Image(.movie2),
            title: "극장판 귀멸의 칼날: 무한성 편",
            audienceCnt: "10만"
        ),
        MovieModel(
            posterImage: Image(.movie3),
            title: "F1: 더 무비",
            audienceCnt: "20만"
        ),
        MovieModel(
            posterImage: Image(.movie4),
            title: "얼굴",
            audienceCnt: "5만"
        ),
        MovieModel(
            posterImage: Image(.movie5),
            title: "모노노케 히메",
            audienceCnt: "7만"
        )
    ]
    
    var feedList: [MovieFeed] = [
        MovieFeed(title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉", description: "<모노노케 히메>,<퍼펙트 블루>", posterImage: Image(.feed1)),
        MovieFeed(title: "메가박스 오리지널 티켓 Re.37 <얼굴>", description: "영화 속 양극적인 감정의 대비", posterImage: Image(.feed2))
    ]
}
