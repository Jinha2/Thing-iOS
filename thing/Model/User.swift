//
//  UserModel.swift
//  thing
//
//  Created by 박진하 on 17/06/2019.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let nickName, uid: String
    let dateBirth: Int
    let profileURL, gender: String
    let resSearches: [Search]
    let resCategories: [Category]

    enum CodingKeys: String, CodingKey {
        case id, nickName, uid, dateBirth
        case profileURL = "profileUrl"
        case gender, resSearches, resCategories
    }
}

struct Category: Decodable {
    let id: Int
    let categoryType: String
}

struct Search: Decodable {
    let createAt: String
    let id: Int
    let text: String
}
