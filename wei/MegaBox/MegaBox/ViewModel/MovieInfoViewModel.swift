//
//  MovieInfoViewModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation

@Observable
class MovieInfoViewModel {
    var movieInfo = [
        MovieInfo(name:"F1: 더 무비",
                  englishName:"F1: The Movie",
                  description:"최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.",
                  poster:"f1Poster",
                  date:"2025.06.25",
                  age:12)
     ]
}
