//
//  MovieInfoModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation

struct MovieInfo : Identifiable, Hashable  {
    let id = UUID()
    var name: String
    var englishName : String
    var description: String
    var poster: String
    var date : String
    var age : Int
    
}
