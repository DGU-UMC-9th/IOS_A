//
//  HomeModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/7/25.
//

import Foundation

struct Movie : Identifiable, Hashable  {
    let id = UUID()
    var name: String
    var imageName: String
    var audience : String
    
}

