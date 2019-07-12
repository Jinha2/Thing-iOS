//
//  YoutuberPopularVideoTableViewCell.swift
//  thing
//
//  Created by 이호찬 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class YoutuberPopularVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var videos = [Video]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension YoutuberPopularVideoTableViewCell {
    func setCollectionView() {

        collectionView.delegate = self
        collectionView.dataSource = self

        setCollectionViewLayout()
    }

    func setCollectionViewLayout() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 163, height: 125)
            flowLayout.minimumInteritemSpacing = 8
        }
    }
}

extension YoutuberPopularVideoTableViewCell {
    func configure(_ videos: [Video]) {
        self.videos = videos
    }
}

extension YoutuberPopularVideoTableViewCell: UICollectionViewDelegate {

}

extension YoutuberPopularVideoTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YoutuberPopularVideoCollectionViewCell", for: indexPath) as? YoutuberPopularVideoCollectionViewCell else { return .init() }
        cell.configure(videos[indexPath.row])
        return cell
    }
}
