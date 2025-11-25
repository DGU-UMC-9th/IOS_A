//
//  NavigationRouterModel.swift
//  Megabox
//
//  Created by 송민교 on 10/4/25.
//

import SwiftUI

enum Route: Hashable{
    case detail(movie:MovieModel)
    case detailOrder
}
