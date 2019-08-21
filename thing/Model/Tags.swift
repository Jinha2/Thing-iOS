//
//  Tags.swift
//  thing
//
//  Created by Jinha Park on 2019/08/08.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

struct Tags: Decodable {
    let tags: [Tag]
}

struct Tag: Decodable {
    let category: String
    let list: [String]
}

struct TagCell {
    let category: String
    var list: [TagList]
}

struct TagList {
    let title: String
    var isSelected: Bool

    mutating func didSelect() {
        isSelected = !isSelected
    }
}
