//
//  RecommendTitleCollectionViewCell.swift
//  thing
//
//  Created by 이재성 on 2019/08/21.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class RecommendTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var youtuberName: UILabel!
    @IBOutlet weak var youtuberCategory: UILabel!
    private var model: Recommend? {
        didSet {
            if let thumbnail = model?.thumbnail, let url = URL(string: thumbnail) {
                imageView.kf.setImage(with: url)
            }
            youtuberName.text = model?.name
            youtuberCategory.text = model?.category
        }
    }

    func setModel(model: Recommend?) {
        self.model = model
    }
}
