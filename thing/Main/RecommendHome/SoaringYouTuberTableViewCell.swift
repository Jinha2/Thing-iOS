//
//  SoaringYouTuberTableViewCell.swift
//  thing
//
//  Created by 이재성 on 2019/08/21.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class SoaringYouTuberTableViewCell: UITableViewCell {
    @IBOutlet weak var youtuberImage: UIImageView!
    @IBOutlet weak var youtuberName: UILabel!
    @IBOutlet weak var youtuberCategory: UILabel!
    @IBOutlet weak var youtuberSoaring: UILabel!
    private var model: Recommend? {
        didSet {
            if let thumbnail = model?.thumbnail, let url = URL(string: thumbnail) {
                youtuberImage.kf.setImage(with: url)
            }
            youtuberName.text = model?.name
            youtuberCategory.text = model?.category
            if let soaring = model?.soaring {
                youtuberSoaring.text = "\(soaring)"
            }
        }
    }

    func setModel(model: Recommend?) {
        self.model = model
    }
}
