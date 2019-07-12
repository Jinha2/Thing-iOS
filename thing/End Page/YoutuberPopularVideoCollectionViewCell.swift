//
//  YoutuberPopularVideoCollectionViewCell.swift
//  thing
//
//  Created by 이호찬 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import Kingfisher

class YoutuberPopularVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

}

extension YoutuberPopularVideoCollectionViewCell {
    func configure(_ video: Video) {
        titleLabel.text = video.title

        let url = URL(string: video.thumbnail)
        thumbnailImageView.kf.setImage(with: url)
    }
}
