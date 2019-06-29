//
//  YoutubePlayerViewController.swift
//  thing
//
//  Created by 이호찬 on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import YoutubeKit

class YoutubePlayerViewController: UIViewController {

    private var player: YTSwiftyPlayer!
    @IBOutlet weak var youtubePlayerView: UIView!
    @IBOutlet weak var playButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton()

        playButton.isEnabled = false
        // Create a new player
        player = YTSwiftyPlayer(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 480),
            playerVars: [.videoID("G_22bAj9m0w"), .showRelatedVideo(false), .playsInline(true)])

//        player = YTS
        // Enable auto playback when video is loaded
        player.autoplay = false

        // Set player view.
        view.addSubview(player)

        // Set delegate for detect callback information from the player.
        player.delegate = self

        // Load the video.
        player.loadPlayer()
        // Do any additional setup after loading the view.

        // key: AIzaSyA1wnMANvmhftP1AG_0-3S4pgmS2zy8L08
    }

    @IBAction private func playTouchedAction(_ sender: UIButton) {
        player.playVideo()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension YoutubePlayerViewController {
    func setButton() {
        playButton.setTitle("기다려", for: .disabled)
        playButton.setTitle("시작", for: .normal)
    }
}

extension YoutubePlayerViewController {
    func youtubePlayer() {
        let request = VideoListRequest(part: [.id, .statistics], filter: .chart)

        // Send a request.
        ApiSession.shared.send(request) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failed(let error):
                print(error)
            }
        }
    }

    func readyToPlay(_ player: YTSwiftyPlayer) {
        playButton.isEnabled = true

    }
}

extension YoutubePlayerViewController: YTSwiftyPlayerDelegate {
    func playerReady(_ player: YTSwiftyPlayer) {
        readyToPlay(player)
//        player.playVideo()
    }
}
