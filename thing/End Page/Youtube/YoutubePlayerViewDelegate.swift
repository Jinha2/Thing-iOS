//
//  YoutubePlayerViewDelegate.swift
//  thing
//
//  Created by 이호찬 on 2019/07/25.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import YoutubeKit

protocol YoutubePlayerViewDelegate: class {
    /**
     - parameters:
     - player: The current active player instance.
     - state: The updated player state.
     */
    func player(_ player: YoutubePlayerView, didChangeState state: PlayerState)

    /**
     - parameters:
     - player: The current active player instance.
     - quality: The updated video quality.
     */
    func player(_ player: YoutubePlayerView, didChangeQuality quality: VideoQuality)

    /**
     - parameters:
     - player: The current active player instance.
     - error: The received error.
     */
    func player(_ player: YoutubePlayerView, didReceiveError error: PlayerError)

    /**
     - parameters:
     - player: The current active player instance.
     - currentTime: The updated current time of video duration.
     */
    func player(_ player: YoutubePlayerView, didUpdateCurrentTime currentTime: Double)

    /**
     - parameters:
     - player: The current active player instance.
     - playbackRate: The updated playback rate of video.
     */
    func player(_ player: YoutubePlayerView, didChangePlaybackRate playbackRate: Double)

    /**
     Notify that the player can be play a video.
     
     - parameters:
     - player: The current active player instance.
     */
    func playerReady(_ player: YoutubePlayerView)

    /**
     This event is issued to indicate that the player has read (or unloaded) the module with a direct API method.
     
     - parameters:
     - player: The current active player instance.
     */
    func apiDidChange(_ player: YoutubePlayerView)

    /**
     API calls this function when downloading JavaScript for player API on page. This will allow you to use the API on the page. With this function you can create a player object to display when the page is loaded.
     
     - parameters:
     - player: The current active player instance.
     */
    func youtubeIframeAPIReady(_ player: YoutubePlayerView)

    /**
     API calls this function when JavaScript for player API loading is failed on page.
     
     - parameters:
     - player: The current active player instance.
     */
    func youtubeIframeAPIFailedToLoad(_ player: YoutubePlayerView)
}

// Default implementation of delegate methods, These delegate functions are option.
extension YoutubePlayerViewDelegate {

    /**
     * Invoked when player state has changed.
     *
     * - parameters:
     *     - player: The player instance that is reflected latest state.
     *     - state: The current player state.
     */
    func player(_ player: YoutubePlayerView, didChangeState state: PlayerState) {}

    /**
     * Invoked when video quality has changed.
     *
     * - parameters:
     *     - player: The player instance that is reflected a new quality.
     *     - quality: The current video quality.
     */
    func player(_ player: YoutubePlayerView, didChangeQuality quality: VideoQuality) {}

    /**
     * Invoked when error has occurred.
     *
     * - parameters:
     *     - player: The player instance where the error has occurred.
     *     - error: The error containing a reason.
     */
    func player(_ player: YoutubePlayerView, didReceiveError error: PlayerError) {}

    /**
     * Invoked when video duration has changed.
     *
     * - parameters:
     *     - player: The player instance that is updated a latest duration.
     *     - currentTime: The current video duration.
     */
    func player(_ player: YoutubePlayerView, didUpdateCurrentTime currentTime: Double) {}

    /**
     * Invoked when playback rate has changed.
     *
     * - parameters:
     *     - player: The player instance that is updated a new playback.
     *     - playbackRate: The current player state.
     */
    func player(_ player: YoutubePlayerView, didChangePlaybackRate playbackRate: Double) {}

    /**
     * Invoked when player is ready to play a video.
     *
     * - parameters:
     *     - player: The player instance that has ready to play a video.
     */
    func playerReady(_ player: YoutubePlayerView) {}

    /**
     * Invoked when API has changed.
     *
     * - parameters:
     *     - player: The player instance that API has changed.
     */
    func apiDidChange(_ player: YoutubePlayerView) {}

    /**
     * Invoked when Youtube IFrame API has ready to call.
     *
     * - parameters:
     *     - player: The player instance that has ready to call API.
     */
    func youtubeIframeAPIReady(_ player: YoutubePlayerView) {}

    /**
     * Invoked when Youtube IFrame API has failed to call.
     *
     * - parameters:
     *     - player: The player instance that has faile to load API .
     */
    func youtubeIframeAPIFailedToLoad(_ player: YoutubePlayerView) {}
}
