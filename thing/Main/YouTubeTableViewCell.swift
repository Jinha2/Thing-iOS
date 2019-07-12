//
//  YoutubeTableViewCell.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import Kingfisher

class YoutubeTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!

    private func reset() {
        thumbnailImageView.image = nil
        profileImageView.image = UIImage(named: "profileBtn")
        titleLabel.text = nil
        countLabel.text = nil
        rankLabel.isHidden = true
    }

    func contents(_ model: RankingList) {
        reset()

        if let thumbnail = model.thumbnail {
            let url = URL(string: thumbnail)
            profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "profileBtn"))
        }

        if let bannerImage = model.bannerImgUrl {
            let url = URL(string: bannerImage)
            thumbnailImageView.kf.setImage(with: url)
        }

        rankLabel.isHidden = false
        rankLabel.text = "\(model.ranking)"
        titleLabel.text = model.name
        countLabel.text = "구독 \(model.subscriberCount) · 조회수 \(model.viewCount)"
    }
}
