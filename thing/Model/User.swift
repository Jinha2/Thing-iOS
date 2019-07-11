//
//  UserModel.swift
//  thing
//
//  Created by 박진하 on 17/06/2019.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

struct User: Decodable {
    let dateBirth: Double
    let gender: Int
    let nickName: String
    let uid: String
}
