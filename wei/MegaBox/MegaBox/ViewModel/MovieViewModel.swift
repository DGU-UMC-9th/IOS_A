//
//  HomeViewModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation

@Observable
class MovieViewModel {
    var movies = [
        Movie(name:"어쩔수가 없다", imageName: "djWjftnrk", audience:"20만"),
        Movie(name:"극장판 귀멸의 칼날", imageName:"infinityCastle", audience:"20만"),
        Movie(name:"F1: 더 무비", imageName: "f1" , audience:"20만"),
        Movie(name:"보스", imageName: "boss" , audience:"20만"),
        Movie(name:"모노노케 히메", imageName: "mononoke" , audience:"20만"),
        Movie(name:"야당", imageName: "yaDang" , audience:"20만"),
    ]
}


