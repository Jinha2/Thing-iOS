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

    override func awakeFromNib() {
        super.awakeFromNib()

        roundCorners()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func roundCorners() {
        backgroundColor = .clear
        contentView.backgroundColor = .white

        contentView.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.clipsToBounds = true
    }
}

extension YoutuberInfoTableViewCell {
    func configure(_ youtuber: Youtuber?) {
        youtuberNameLabel.text = youtuber?.name
        subscribeNumLabel.text = (insertCommas(youtuber?.subscriberCount ?? 0) ?? "0") + " 명"

        if let thumbNail = youtuber?.thumbnail {
            let url = URL(string: thumbNail)
            youtuberImageView.kf.setImage(with: url)
        }
    }

    func insertCommas(_ num: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: num))
    }
}
