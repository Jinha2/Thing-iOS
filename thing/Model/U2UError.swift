//
//  Error.swift
//  thing
//
//  Created by JERCY on 22/07/2019.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

struct U2UError: Decodable {
    let error: UError
}

struct UError: Decodable {
    let code: Int
    let massage: String
}
