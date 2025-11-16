//
//  Protocol.swift
//  APIManager
//
//  Created by 백지은 on 11/16/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
