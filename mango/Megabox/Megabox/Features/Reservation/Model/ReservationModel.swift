//
//  MovieSelectModel.swift
//  Megabox
//
//  Created by 송민교 on 10/12/25.
//

import Foundation
import SwiftUI

struct MovieSelectModel: Identifiable{
    let id = UUID()
    let movieImageName: String
    // let ageLimit: Int
    var title: String
    var isSelected: Bool
}

enum TheaterType: String, CaseIterable, Identifiable{
    case gangnam = "강남"
    case hongdae = "홍대"
    case sinchon = "신촌"
    
    var id: String {rawValue} // id로 자신의 rawValue(문자열) 사용
}
struct TheaterInfo: Identifiable{
    let id = UUID()
    let theater:TheaterType
    let movie: MovieSelectModel
    let theaterDetail: String
    let movieTime: [MovieTime]
    let movieDate: String
}

struct MovieTime: Identifiable{
    let id = UUID()
    let startTime: String
    let endTime: String
    let leftSeats: Int
    let totalSeats: Int
}
