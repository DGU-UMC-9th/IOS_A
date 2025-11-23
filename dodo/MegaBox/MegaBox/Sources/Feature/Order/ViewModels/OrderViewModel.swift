//
//  OrderViewModel.swift
//  MegaBox
//
//  Created by 김도연 on 11/21/25.
//

import SwiftUI
import Observation

@Observable
class OrderViewModel {
    var menuList : [MenuItemModel] = [
        MenuItemModel(title: "러브 콤보", price: "10,900원", image: "realPopcorn", badge: .best, isAvailable: true, salesPrice: nil),
        MenuItemModel(title: "더블 콤보", price: "24,900원", image: "realPopcorn", badge: .recommend, isAvailable: true, salesPrice: nil),
        MenuItemModel(title: "싱글 콤보", price: "10,900원", image: "realPopcorn", badge: .best, isAvailable: true, salesPrice: nil),
        MenuItemModel(title: "러브 콤보 패키지", price: "10,900원", image: "realPopcorn", badge: nil, isAvailable: true, salesPrice: nil),
        MenuItemModel(title: "패밀리 콤보 패키지", price: "10,900원", image: "realPopcorn", badge: nil, isAvailable: true, salesPrice: nil),
        MenuItemModel(title: "너 품절이야", price: "20,900원", image: "realPopcorn", badge: nil, isAvailable: false, salesPrice: "16,900원")
    ]
}
