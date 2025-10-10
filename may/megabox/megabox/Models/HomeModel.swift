//
//  HomeModel.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import Foundation

enum MovieTab: String, CaseIterable {
    case chart = "무비차트"
    case comingSoon = "상영예정"
    
    var title: String {
        return self.rawValue
    }
}
