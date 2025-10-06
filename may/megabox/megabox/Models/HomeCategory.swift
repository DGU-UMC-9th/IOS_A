//
//  HomeCategory.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//


import SwiftUI
import Foundation


enum HomeCategory :String, CaseIterable {
    case home = "홈"
    case event = "이벤트"
    case store = "스토어"
    case prefer = "선호극장"
    
    var getName : String{
        return self.rawValue
    }
}
