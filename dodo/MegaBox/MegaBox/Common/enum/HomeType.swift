//
//  HomeType.swift
//  MegaBox
//
//  Created by 김도연 on 9/29/25.
//

enum HomeType: String, CaseIterable {
    case home = "홈"
    case event = "이벤트"
    case store = "스토어"
    case prefer = "선호극장"
    
    var description: String {
        return self.rawValue
    }
}
