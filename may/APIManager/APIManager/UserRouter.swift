//
//  UserRouter.swift
//  APIManager
//
//  Created by 백지은 on 11/16/25.
//

import Foundation
import Moya
import Alamofire

enum UserRotuer {
    case getPerson(name: String)
    case getMyInfo
    case postPerson(userData: UserData)
    case patchPerson(userId: Int, patchData: UserPatchRequest)
    case putPerson(userId: Int, userData: UserData)
    case deletePerson(userId: Int)
}

extension UserRotuer: APITargetType {
    
    var path: String {
        switch self {
        case .getPerson, .postPerson:
            return "/api/user"
        case .getMyInfo:
            return "/api/user/my"
        case .patchPerson(let userId, _),
             .putPerson(let userId, _),
             .deletePerson(let userId):
            return "/api/user/\(userId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPerson, .getMyInfo:
            return .get
        case .postPerson:
            return .post
        case .patchPerson:
            return .patch
        case .putPerson:
            return .put
        case .deletePerson:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getPerson(let name):
            return .requestParameters(parameters: ["name": name], encoding: URLEncoding.queryString)
        case .getMyInfo:
            return .requestPlain
        case .postPerson(let userData):
            return .requestJSONEncodable(userData)
        case .patchPerson(_, let patchData):
            return .requestJSONEncodable(patchData)
        case .putPerson(_, let userData):
            return .requestJSONEncodable(userData)
        case .deletePerson:
            return .requestPlain
        }
    }
}
