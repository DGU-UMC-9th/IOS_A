//
//  HomeViewModel.swift
//  Megabox
//
//  Created by 송민교 on 10/5/25.
//

import SwiftUI
import Observation

@Observable
class MovieViewModel {
    var currentIndex: Int = 0
    
    let movieChartList: [MovieModel] = [
        .init(
            movieTitle: "어쩔수가없다",
            movieCount: "20만",
            movieImageName: "movie5",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "No Choice",
            tagline: "어쩔 수 없는 운명...",
            synopsis: "어쩔 수 없는 선택 앞에 놓인 한 남자의 이야기.",
            rating: "전체 관람가",
            releaseDate: "2025.10.01 개봉"
        ),
        .init(
            movieTitle: "귀멸의 칼날",
            movieCount: "1",
            movieImageName: "movie3",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "",
            tagline: "되살아나는 전설",
            synopsis: "귀살대 탄지로의 새로운 임무가 시작된다.",
            rating: "15세 이상 관람가",
            releaseDate: "2024.02.14 개봉"
        ),
        .init(
            movieTitle: "F1",
            movieCount: "20만",
            movieImageName: "f1",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "F1: The Movie",
            tagline: "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키",
            synopsis: "한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고 한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트). 그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.",
            rating: "12세 이상 관람가",
            releaseDate: "2025.06.25 개봉"
        ),
        .init(
            movieTitle: "얼굴",
            movieCount: "5만",
            movieImageName: "face",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "The Face",
            tagline: "그의 얼굴에 담긴 비밀",
            synopsis: "신비로운 얼굴을 가진 남자의 정체는?",
            rating: "전체 관람가",
            releaseDate: "2025.09.15 개봉"
        ),
        .init(
            movieTitle: "모노노케 히메",
            movieCount: "10만",
            movieImageName: "mononoke",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "Princess Mononoke",
            tagline: "살아라",
            synopsis: "인간과 자연의 갈등을 그린 지브리 명작.",
            rating: "전체 관람가",
            releaseDate: "1997.07.12 개봉"
        )
    ]
    
    let comingSoonList: [MovieModel] = [
        .init(
            movieTitle: "The Roses",
            movieCount: "20만",
            movieImageName: "theroses",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "The Roses",
            tagline: "그들의 이야기가 시작된다",
            synopsis: "장미꽃처럼 아름답고 잔인한 이야기.",
            rating: "15세 이상 관람가",
            releaseDate: "2025.11.01 개봉"
        ),
        .init(
            movieTitle: "보스",
            movieCount: "1",
            movieImageName: "boss",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "The Boss",
            tagline: "진정한 보스의 탄생",
            synopsis: "조직의 보스가 되기 위한 치열한 경쟁.",
            rating: "청소년 관람불가",
            releaseDate: "2025.12.01 개봉"
        ),
        .init(
            movieTitle: "야당",
            movieCount: "20만",
            movieImageName: "movie4",
            topPosterImageName: "TopPoster_f1",
            bottomPosterImageName: "BottomPoster_f1",
            originalTitle: "The Opposition",
            tagline: "그들의 반란이 시작된다",
            synopsis: "거대한 권력에 맞서는 야당의 이야기.",
            rating: "12세 이상 관람가",
            releaseDate: "2025.12.25 개봉"
        )
    ]
}
