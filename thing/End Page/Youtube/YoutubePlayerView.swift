//
//  YoutubePlayerView.swift
//  thing
//
//  Created by 이호찬 on 2019/07/25.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import YoutubeKit

class YoutubePlayerView: UIView {

    private var player: YTSwiftyPlayer!
    private var defaultVars: [VideoEmbedParameter] = [.showRelatedVideo(false), .autoplay(true), .playsInline(true), .showLoadPolicy(false), .showInfo(false)]

    var autoplay: Bool {
        get {
            return player.autoplay
        } set {
            player.autoplay = newValue
        }
    }

    var playerState: PlayerState? {
        return PlayerState(rawValue: player.playerState.rawValue)
    }

    var playerEvent: PlayerEvent? {
        return PlayerEvent(rawValue: player.playerQuality.rawValue)
    }

    var playerQuality: YTSwiftyVideoQuality = .unknown

    var duration: Double? {
        return player.duration
    }

    var currentTime: Double {
        return player.currentTime
    }

    var title: String? {
        return player.title
    }

    var isMuted: Bool {
        return player.isMuted
    }

    weak var delegate: YoutubePlayerViewDelegate?

    //일단 급한대로 코드로 init 만 설정..... 추후 player 설정할때 id 가 제대로 들어가면 인터페이스빌더도 적용 예정
    convenience init(id: String) {
        self.init(frame: .zero)

        setPlayer(id: id)
        setLayout()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //
    //        setPlayer()
    //        setLayout()
    //    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

// MARK: - initail Setting
extension YoutubePlayerView {
    private func setLayout() {
        self.addSubview(player)

        NSLayoutConstraint.activate([
            player.topAnchor.constraint(equalTo: topAnchor),
            player.leadingAnchor.constraint(equalTo: leadingAnchor),
            player.trailingAnchor.constraint(equalTo: trailingAnchor),
            player.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setPlayer(id: String) {
        defaultVars.append(.videoID(id))
        player = YTSwiftyPlayer(frame: .zero, playerVars: defaultVars)

        player.delegate = self

        player.translatesAutoresizingMaskIntoConstraints = false
        player.loadPlayer()
    }
}

extension YoutubePlayerView {

}

// MARK: - Call IFrame API during playback.
extension YoutubePlayerView {
    func playVideo() {
        player.playVideo()
    }

    func pauseVideo() {
        player.pauseVideo()
    }

    func seek(to: Int, allowSeekAhead: Bool) {
        player.seek(to: to, allowSeekAhead: allowSeekAhead)
    }

    func mute() {
        player.mute()
    }

    func loadVideo(videoID: String) {
        player.loadVideo(videoID: videoID)
    }

    func loadPlayer(id: String) {
        player.loadPlayer()
    }

    func clearVideo() {
        player.clearVideo()
    }
}

// MARK: - YTSwiftyPlayerDelegate
extension YoutubePlayerView: YTSwiftyPlayerDelegate {
    func playerReady(_ player: YTSwiftyPlayer) {
        delegate?.playerReady(self)
    }

    func player(_ player: YTSwiftyPlayer, didUpdateCurrentTime currentTime: Double) {
        delegate?.player(self, didUpdateCurrentTime: currentTime)
    }

    func player(_ player: YTSwiftyPlayer, didChangeState state: YTSwiftyPlayerState) {
        delegate?.player(self, didChangeState: PlayerState(rawValue: state.rawValue) ?? .unstarted)
    }

    func player(_ player: YTSwiftyPlayer, didChangePlaybackRate playbackRate: Double) {
        delegate?.player(self, didChangePlaybackRate: playbackRate)
    }

    func player(_ player: YTSwiftyPlayer, didReceiveError error: YTSwiftyPlayerError) {
        delegate?.player(self, didReceiveError: PlayerError(rawValue: error.rawValue) ?? .error)
    }

    func player(_ player: YTSwiftyPlayer, didChangeQuality quality: YTSwiftyVideoQuality) {
        delegate?.player(self, didChangeQuality: VideoQuality.initString(quality.rawValue))
    }

    func apiDidChange(_ player: YTSwiftyPlayer) {
        delegate?.apiDidChange(self)
    }

    func youtubeIframeAPIReady(_ player: YTSwiftyPlayer) {
        delegate?.youtubeIframeAPIReady(self)
    }

    func youtubeIframeAPIFailedToLoad(_ player: YTSwiftyPlayer) {
        delegate?.youtubeIframeAPIFailedToLoad(self)
    }
}
