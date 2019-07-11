//
//  YoutubeModel.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

struct Youtube: Decodable {
    let thumbnailUrl: String
    let profileUrl: String
    let title: String
    let rank: String
    let subscriberCount: String
    let viewCount: String
}
