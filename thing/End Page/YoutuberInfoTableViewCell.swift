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
    @IBOutlet weak var categoryTagLabel: UILabel!
    @IBOutlet weak var commonTagLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

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
        guard let youtuber = youtuber else { return }
        youtuberNameLabel.text = youtuber.name
        subscribeNumLabel.text = (insertCommas(youtuber.subscriberCount) ?? "0") + " 명"

        if let thumbNail = youtuber.thumbnail {
            let url = URL(string: thumbNail)
            youtuberImageView.kf.setImage(with: url)
        }
        channelId = youtuber.channelId
        categoryLabel.text = youtuber.category

        if !youtuber.categoryTags.isEmpty {
            categoryTagLabel.isHidden = false
            categoryTagLabel.attributedText = setTags(youtuber.categoryTags, color: UIColor(red: 254 / 255, green: 0, blue: 0, alpha: 0.3))
        } else {
            categoryTagLabel.isHidden = true
        }

        if !youtuber.commonTags.isEmpty {
            commonTagLabel.isHidden = false
            commonTagLabel.attributedText = setTags(youtuber.commonTags, color: UIColor(red: 55 / 255, green: 55 / 255, blue: 55 / 255, alpha: 0.3))
        } else {
            commonTagLabel.isHidden = true
        }
    }
}

extension YoutuberInfoTableViewCell {
    private func insertCommas(_ num: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: num))
    }

    private func setTags(_ tags: [String], color: UIColor) -> NSMutableAttributedString {
        let entireString = tags.joined(separator: " • ")
        let highlightString = "•"

        let attrStr = NSMutableAttributedString(string: entireString)
        let entireLength = entireString.count
        var range = NSRange(location: 0, length: entireLength)
        var rangeArr = [NSRange]()

        while range.location != NSNotFound {
            range = (attrStr.string as NSString).range(of: highlightString, options: .caseInsensitive, range: range)
            rangeArr.append(range)

            if range.location != NSNotFound {
                range = NSRange(location: range.location + range.length, length: entireString.count - (range.location + range.length))
            }
        }
        rangeArr.forEach { range in
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        return attrStr
    }
}

extension YoutuberInfoTableViewCell {
    private func playInYoutube(youtubeId: String) {
        if let youtubeURL = URL(string: "https://www.youtube.com/channel/\(youtubeId)") {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }
    }
}
