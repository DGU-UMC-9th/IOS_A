// TokenProviding.swift

import Foundation

protocol TokenProviding {
    var accessToken: String? { get }
    var refreshToken: String? { get }
    
    func update(accessToken: String)
    func update(refreshToken: String)
    func clear()
}

