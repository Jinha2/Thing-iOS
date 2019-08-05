//
//  UserModel.swift
//  thing
//
//  Created by 박진하 on 17/06/2019.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

class UserInstance {
    private static let instance = UserInstance()
    private var user: User?

    class func getUser() -> User? {
        return UserInstance.instance.user
    }

    class func setUser(user: User?) {
        UserInstance.instance.user = user
    }

    private init() { }
}

struct User: Decodable {
    let id: Int
    let uid: String
    let nickName: String?
    let dateBirth: Int?
    let gender: String?
    let profileUrl: String?
//    let searches: [Search]
    let categories: [CategoryList]?
    let categoryTag: [String]?
    let commonTag: [String]
}

struct CategoryList: Decodable {
    let id: Int
    let categoryType: String
}

struct Search: Decodable {
    let createAt: String
    let id: Int
    let text: String
}
