//
//  RecommendYoutuberTableViewCell.swift
//  thing
//
//  Created by 이재성 on 2019/08/21.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class RecommendYoutuberTableViewCell: UITableViewCell {
    @IBOutlet weak var youtuberImage: UIImageView!
    @IBOutlet weak var youtuberName: UILabel!
    @IBOutlet weak var youtuberCategory: UILabel!
    @IBOutlet weak var youtuberTag: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: YoutuberPopularVideoTableViewCellDelegate?
    private var model: Recommend? {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self

            if let thumbnail = model?.thumbnail, let url = URL(string: thumbnail) {
                youtuberImage.kf.setImage(with: url)
            }
            youtuberName.text = model?.name
            youtuberCategory.text = model?.category
            youtuberTag.text = model?.tag.reduce("") {
                $0 + " " + $1
            }

            collectionView.reloadData()
        }
    }

    func setModel(model: Recommend?) {
        self.model = model
    }
}

extension RecommendYoutuberTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let video = model?.videos?[indexPath.row], let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YoutuberPopularVideoCollectionViewCell", for: indexPath) as? YoutuberPopularVideoCollectionViewCell else { return .init() }
        cell.configure(video)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = model?.videos?[indexPath.row].youtubeVideoId else { return }
        delegate?.goToPlayer(id)
    }
}
