//
//  MovieModel.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI
import Foundation

struct MovieModel: Identifiable {
    let id = UUID()
    var posterImage: Image
    var title: String
    var audienceCnt: String
    
    func toDetail() -> MovieDetail {
        if(title=="F1: 더 무비"){
            MovieDetail(
                headerImage: Image(.detailImg),
                posterImage: Image(.detailPoster),
                title: "F1 더 무비",
                engTitle: "F1 : The Movie",
                description: "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고 한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.",
                ageRating: "12세 이상 관람가",
                releaseDate: "2025.06.25 개봉"
            )
        }
        else{
            MovieDetail(
                headerImage: self.posterImage,
                posterImage: self.posterImage,
                title: self.title,
                engTitle: self.title,
                description: "내용 없음",
                ageRating: "12세 연령 제한가",
                releaseDate: "2025.10.04 개봉"
            )
        }
    }
}

struct MovieDetail: Identifiable {
    let id = UUID()
    var headerImage: Image
    var posterImage: Image
    var title: String
    var engTitle: String
    var description: String
    var ageRating: String
    var releaseDate: String
}

struct MovieFeed: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var posterImage: Image
}
