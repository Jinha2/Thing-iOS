//
//  YoutubePlayerView.swift
//  thing
//
//  Created by 이호찬 on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import YoutubeKit

class YoutubePlayerView: UIView {

    private var player: YTSwiftyPlayer!
    
    convenience init() {
        self.init()
        
        player = YTSwiftyPlayer(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 480),
            playerVars: [.videoID("G_22bAj9m0w"), .showRelatedVideo(false), .playsInline(true)])
        
        //        player = YTS
        // Enable auto playback when video is loaded
        player.autoplay = false
        
        // Set player view.
        self.addSubview(player)
        
        // Set delegate for detect callback information from the player.
        player.delegate = self
        
        // Load the video.
        player.loadPlayer()
    }

}

extension YoutubePlayerView: YTSwiftyPlayerDelegate {
    func playerReady(_ player: YTSwiftyPlayer) {
//        readyToPlay(player)
    }
}
