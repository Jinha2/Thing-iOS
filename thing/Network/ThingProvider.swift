//
//  ThingProvider.swift
//  thing
//
//  Created by 박진하 on 2019/06/19.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation
import Moya
import Result

class ThingProvider {
    let provider = MoyaProvider<ThingService>()

    func signIn(completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {

        provider.request(.signIn) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }

    func signUp(uid: String, nickname: String, gender: Int?, birth: Int?, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.signUp(uid: uid, nickname: nickname, gender: gender, birth: birth)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }

    func rankings(filter: String, page: Int, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.rankings(filter: filter, page: page)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }

    func categories(categoryId: Int, filter: String, page: Int, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.categories(categoryId: categoryId, filter: filter, page: page)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }

    func youtuber(id: Int, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.youtuber(id: id)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
}

extension ThingProvider {
    func resultTask(_ result: Result<Response, MoyaError>, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        switch result {
        case .success(let response):
            let data = response.data
            let statusCode = response.statusCode

            if statusCode >= 300 {
                failure(MoyaError.statusCode(response))
            } else {
                completion(data)
            }
        case let .failure(error):
            failure(error)
        }
    }
}
