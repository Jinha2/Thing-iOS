//
//  Youtuber.swift
//  thing
//
//  Created by 이호찬 on 2019/07/12.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

struct Youtuber: Decodable {
    let bannerImgUrl: String
    let channelId: String
    let description: String
    let id: Int
    let likeReviews: [Review]
    let name: String
    let noReviews: [Review]
    let publishedAt: Date
    let subscriberCount: Int
    let thumbnail: String
    let videos: [Video]
    let viewCount: Int
}

struct Review: Decodable {
    let createAt: Date
    let id: Int
    let liked: String
    let nickName: String
    let profileUrl: String
    let text: String
}

struct Video: Decodable {
    let id: Int
    let publishedAt: Date
    let thumbnail: String
    let title: String
    let youtubeVideoId: String
}
