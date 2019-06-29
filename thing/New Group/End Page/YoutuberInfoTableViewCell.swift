//
//  YoutuberInfoTableViewCell.swift
//  thing
//
//  Created by 이호찬 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class YoutuberInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var youtuberImageView: UIImageView!
    @IBOutlet weak var youtuberNameLabel: UILabel!
    @IBOutlet weak var subscribeNumLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        roundCorners()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func roundCorners() {
        let corners: UIRectCorner = [.topLeft, .topRight]
        let radius: CGFloat = 20

        let path = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

}
