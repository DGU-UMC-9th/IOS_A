//
//  Type.swift
//  Megabox
//
//  Created by 송민교 on 11/22/25.
//
import SwiftUI
import Foundation

enum TheaterType: String, CaseIterable, Identifiable{
    case gangnam = "강남"
    case hongdae = "홍대"
    case sinchon = "신촌"
    
    var id: String {rawValue} // id로 자신의 rawValue(문자열) 사용
}
