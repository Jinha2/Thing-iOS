//
//  YoutubePlayerViewController.swift
//  thing
//
//  Created by 이호찬 on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class YoutubePlayerViewController: UIViewController {

    @IBOutlet weak var youtubePlayerView: YoutubePlayerView!
    @IBOutlet weak var playButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton()

        youtubePlayerView.delegate = self
        playButton.isEnabled = false

        youtubePlayerView.loadVideo(videoID: "8JVvrF5bIR4")
        // Create a new player
    }

    @IBAction private func playTouchedAction(_ sender: UIButton) {
        youtubePlayerView.playVideo()
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
    func readyToPlay() {
        playButton.isEnabled = true
    }
}

extension YoutubePlayerViewController: YoutubePlayerViewDelegate {
    func playerReady(_ player: YoutubePlayerView) {
        readyToPlay()
    }
}
