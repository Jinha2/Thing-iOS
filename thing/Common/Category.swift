//
//  Category.swift
//  thing
//
//  Created by Jinha Park on 2019/07/12.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

class Category {
    static let sharedInstance = Category()
    var categories: [CategoryList]?

    private init() {}
}
