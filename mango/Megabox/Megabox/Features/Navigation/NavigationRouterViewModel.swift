//
//  NavigationRouterViewModel.swift
//  Megabox
//
//  Created by 송민교 on 10/4/25.
//

import SwiftUI
import Observation

@Observable
class NavigationRouterViewModel{
    var path = NavigationPath()
    
    func push(_ route:Route){
        path.append(route)
        
    }
    
    func pop(){
        if !path.isEmpty{
            path.removeLast()
        }
    }
    
    func reset(){
        path = NavigationPath()
    }
}
