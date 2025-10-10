//
//  MovieFeedItemModelView.swift
//  Megabox
//
//  Created by 송민교 on 10/6/25.
//

import SwiftUI
import Foundation

@Observable
class MovieFeedItemViewModel: Identifiable{
    var feedList: [MovieFeedItemModel] = [
        .init(thumbnailName: "feedItem_mononoke", title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉’", subtitle: "<모노노케 히메>,<퍼펙트 블루>"),
        .init(thumbnailName: "feedItem_face", title: "메가박스 오리지널 티켓 Re.37 <얼굴>", subtitle: "영화 속 양극적인 감정의 대비")
    ]
}
