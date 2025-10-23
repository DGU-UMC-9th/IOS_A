//
//  Theater.swift
//  MegaBox
//
//  Created by 김도연 on 10/13/25.
//

enum Theater: String, CaseIterable {
    case Gangnam = "강남"
    case Hongdae = "홍대"
    case Sinchon = "신촌"

    var title: String {
        return self.rawValue
    }
}
