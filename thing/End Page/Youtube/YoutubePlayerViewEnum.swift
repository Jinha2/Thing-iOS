//
//  YoutubePlayerViewEnum.swift
//  thing
//
//  Created by 이호찬 on 2019/07/25.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation

enum PlayerState: Int {
    case unstarted  = -1
    case ended = 0
    case playing = 1
    case paused = 2
    case buffering = 3
    case cued = 4
}

enum PlayerEvent: String {
    case onYoutubeIframeAPIReady        = "onYouTubeIframeAPIReady"
    case onYouTubeIframeAPIFailedToLoad = "onYouTubeIframeAPIFailedToLoad"
    case onReady                        = "onReady"
    case onStateChange                  = "onStateChange"
    case onQualityChange                = "onPlaybackQualityChange"
    case onPlaybackRateChange           = "onPlaybackRateChange"
    case onApiChange                    = "onApiChange"
    case onError                        = "onError"
    case onUpdateCurrentTime            = "onUpdateCurrentTime"
}

enum VideoQuality {
    case small
    case medium
    case large
    case hd720
    case hd1080
    case highres
    case unknown

    static func initString(_ str: String?) -> VideoQuality {
        guard let str = str else { return .unknown }
        switch str {
        case "small":
            return .small
        case "medium":
            return .medium
        case "large":
            return .large
        case "hd720":
            return .hd720
        case "hd1080":
            return .hd1080
        case "highres":
            return .highres
        default:
            return .unknown
        }
    }
}

enum PlayerError: Int {
    case invalidURLRequest = 2
    case html5PlayerError = 5
    case videoNotFound = 100
    case videoNotPermited = 101
    case videoLicenseError = 150
    case error = 404
}
