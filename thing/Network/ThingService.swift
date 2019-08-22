//
//  ThingService.swift
//  thing
//
//  Created by 박진하 on 11/06/2019.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation
import Moya

enum ThingService {
    case signIn
    case signUp(uid: String, nickname: String, gender: Int?, birth: Int?)
    case categories(categoryId: Int, filter: String, page: Int)
    case youtuber(id: Int)
    case home
    case tags
    case addTag(category: [String], common: [String])
}

extension ThingService: TargetType {
    var baseURL: URL { return URL(string: "http://13.124.57.224")! }

    var path: String {
        switch self {
        case .signIn:
            return "/v1/sign-in"
        case .signUp:
            return "/v1/users"
        case .categories(let categoryId, _, _):
            return "/v1/categories/\(categoryId)/rankings"
        case .youtuber(let id):
            return "/v1/youtubers/\(id)"
        case .home:
            return "/v1/youtubers/recommendations/home"
        case .tags:
            return "/v1/tags"
        case .addTag:
            return "/v1/youtubers/recommendations"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signUp:
        return .post
        case .signIn, .categories, .youtuber, .home, .tags, .addTag:
        return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .signIn:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .signUp(let uid, let nickname, let gender, let birth):
            var params: [String: Any] = ["uid": uid, "nickname": nickname]

            if let gender = gender {
                params["gender"] = gender
            }

            if let birth = birth {
                params["dateBirth"] = birth
            }

            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .categories(let categoryId, let filter, let page):
            return .requestParameters(parameters: ["categoryId": categoryId, "filter": filter, "page": page], encoding: URLEncoding.default)
        case .youtuber:
            return .requestParameters(parameters: ["userId": UserInstance.getUser()?.id ?? 0], encoding: URLEncoding.default)
        case .home:
            return .requestPlain
        case .tags:
            return .requestPlain
        case .addTag(let category, let common):
            let categoryString = category.reduce("") { $0.isEmpty ? $1 : $0 + "," + $1 }
            let commonString = common.reduce("") { $0.isEmpty ? $1 : $0 + "," + $1 }
            return .requestParameters(parameters: ["category": categoryString, "common": commonString], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        guard let uid = FirebaseLayer.getUid() else { return ["Content-type": "application/json"] }

        return ["Content-type": "application/json", "uid": uid]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
