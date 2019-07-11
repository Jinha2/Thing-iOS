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
    case signUp(uid: String, nickname: String, gender: Int?, birth: Double?)
    case rankings(filter: String, page: Int)
}

extension ThingService: TargetType {
	var baseURL: URL { return URL(string: "http://13.124.57.224")! }

	var path: String {
        switch self {
        case .signUp:
            return "/v1/users"
        case .rankings:
            return "/v1/rankings"
		}
	}

	var method: Moya.Method {
		switch self {
		case .signUp:
			return .post
        case .rankings:
            return .get
		}
	}

	var sampleData: Data {
		return Data()
	}

	var task: Task {
        switch self {
        case .signUp(let uid, let nickname, let gender, let birth):
            var params: [String: Any] = ["uid": uid, "nickname": nickname]

            if let gender = gender {
                params["gender"] = gender
            }

            if let birth = birth {
                params["birth"] = birth
            }

            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .rankings(let filter, let page):
            return .requestParameters(parameters: ["filter": filter, "page": page], encoding: URLEncoding.default)
		}
	}

	var headers: [String: String]? {
//        guard let token = "uid" else { return ["Content-type": "application/json"] }
        let uid = "qwertyasdfg"

        return ["Content-type": "application/json", "uid": uid]
	}
}
