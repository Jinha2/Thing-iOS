//
//  Youtuber.swift
//  thing
//
//  Created by 이호찬 on 2019/07/12.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

struct Youtuber: Decodable {
    let bannerImgUrl: String?
    let channelId: String
    let description: String
    let id: Int
    let likeReviews: [Review]
    let name: String
    let noReviews: [Review]
    let publishedAt: String
    let subscriberCount: Int
    let thumbnail: String?
    let noReviewCount: Int
    let likeReviewCount: Int
    let videos: [Video]
    let viewCount: Int
}

struct Review: Decodable {
    let createAt: Double
    let id: Int
    let liked: String
    let nickName: String
    let owner: Bool
    let profileUrl: String
    let text: String
}

struct Video: Decodable {
    let id: Int
    let publishedAt: String
    let thumbnail: String
    let title: String
    let youtubeVideoId: String
}
