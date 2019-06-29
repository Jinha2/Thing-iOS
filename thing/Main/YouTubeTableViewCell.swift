//
//  YoutubeTableViewCell.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class YoutubeTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var topRankLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!

    private func reset() {
        thumbnailImageView.image = nil
        profileImageView.image = nil
        titleLabel.text = nil
        countLabel.text = nil
        topRankLabel.text = nil
        rankLabel.text = nil
    }

    func contents(_ model: YoutubeModel) {
        reset()

    }
}
