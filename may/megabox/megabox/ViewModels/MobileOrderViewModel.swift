//
//  MobileOrderViewModel.swift
//  megabox
//
//  Created by 백지은 on 11/22/25.
//

import Foundation
import SwiftUI

class MobileOrderViewModel: ObservableObject {
    @Published var menuItems: [MenuItemModel] = []
    
    init() {
        loadMenuItems()
    }
    
    private func loadMenuItems() {
        menuItems = [
            // 싱글 콤보
            MenuItemModel(
                title: "싱글 콤보",
                price: 10900,
                image: Image(.singleCombo),
                badge: .best,
                isSoldOut: false
            ),
            
            // 러브 콤보
            MenuItemModel(
                title: "러브 콤보",
                price: 10900,
                image: Image(.loveCombo),
                badge: .best,
                isSoldOut: false
            ),
            
            // 더블 콤보
            MenuItemModel(
                title: "더블 콤보",
                price: 24900,
                image: Image(.doubleCombo),
                badge: .best,
                isSoldOut: false
            ),
            
            // 러브 콤보 패키지
            MenuItemModel(
                title: "러브 콤보 패키지",
                price: 32000,
                image: Image(.loveComboPackage),
                badge: nil,
                isSoldOut: false
            ),
            
            // 패밀리 콤보 패키지
            MenuItemModel(
                title: "패밀리 콤보 패키지",
                price: 47000,
                image: Image(.loveComboPackage),
                badge: .recommended,
                isSoldOut: false
            ),
            
            // 메가박스 오리지널 티켓북 시즌4
            MenuItemModel(
                title: "메가박스 오리지널 티켓북 시즌4",
                price: 10900,
                image: Image(.book),
                badge: .recommended,
                isSoldOut: false
            ),
            
            // 디즈니 픽사 포스터
            MenuItemModel(
                title: "디즈니 픽사 포스터",
                price: 15900,
                image: Image(.disneyPoster),
                badge: .recommended,
                isSoldOut: true
            ),
            
            // 인사이드아웃2 감정
            MenuItemModel(
                title: "인사이드아웃2 감정",
                price: 29900,
                image: Image(.insideout),
                badge: nil,
                isSoldOut: false
            )
        ]
    }
    
    // 베스트 메뉴만 필터링
    func getBestMenuItems() -> [MenuItemModel] {
        return menuItems.filter { $0.badge == .best }
    }
    
    // 추천 메뉴만 필터링
    func getRecommendedMenuItems() -> [MenuItemModel] {
        return menuItems.filter { $0.badge == .recommended }
    }
}
