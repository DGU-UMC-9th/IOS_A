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
        MovieModel(name:"어쩔수가 없다", imageName: "djWjftnrk", audience:"20만", age:15),
        MovieModel(name:"극장판 귀멸의 칼날", imageName:"infinityCastle", audience:"60만",age:15),
        MovieModel(name:"F1: 더 무비", imageName: "f1" , audience:"10만",age:12),
        MovieModel(name:"보스", imageName: "boss" , audience:"30만",age:15),
        MovieModel(name:"모노노케 히메", imageName: "mononoke" , audience:"40만",age:12),
        MovieModel(name:"야당", imageName: "yaDang" , audience:"50만",age:18),
        MovieModel(name:"얼굴", imageName: "face" , audience:"70만",age:12),
        MovieModel(name:"the Roses", imageName: "theRoses" , audience:"80만",age:15)
    ]
}


