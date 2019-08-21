//
//  YoutuberInfoTableViewCell.swift
//  thing
//
//  Created by 이호찬 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import Kingfisher

class YoutuberInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var youtuberImageView: UIImageView!
    @IBOutlet weak var youtuberNameLabel: UILabel!
    @IBOutlet weak var subscribeNumLabel: UILabel!
    @IBOutlet weak var upperCategoryView: CustomCategoryView!
    @IBOutlet weak var lowerCategoryView: CustomCategoryView!

    private var channelId: String?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction private func goToYoutubeAction(_ sender: UIButton) {
        guard let channelId = channelId else { return }
        playInYoutube(youtubeId: channelId)
    }
}

extension YoutuberInfoTableViewCell {
    func configure(_ youtuber: Youtuber?, category: [String]) {
        youtuberNameLabel.text = youtuber?.name
        subscribeNumLabel.text = (insertCommas(youtuber?.subscriberCount ?? 0) ?? "0") + " 명"

        if let thumbNail = youtuber?.thumbnail {
            let url = URL(string: thumbNail)
            youtuberImageView.kf.setImage(with: url)
        }
        channelId = youtuber?.channelId
        upperCategoryView.setCategory(categorys: category, color: .red)
        lowerCategoryView.setCategory(categorys: category, color: .blue)
    }

    private func insertCommas(_ num: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: num))
    }

    private func playInYoutube(youtubeId: String) {
        if let youtubeURL = URL(string: "https://www.youtube.com/channel/\(youtubeId)") {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }
    }
}
