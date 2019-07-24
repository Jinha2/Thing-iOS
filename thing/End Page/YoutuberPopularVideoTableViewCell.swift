//
//  YoutuberPopularVideoTableViewCell.swift
//  thing
//
//  Created by 이호찬 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

protocol YoutuberPopularVideoTableViewCellDelegate: class {
    func goToPlayer(_ id: String)
}

class YoutuberPopularVideoTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!

    private var videos = [Video]()
    weak var delegate: YoutuberPopularVideoTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension YoutuberPopularVideoTableViewCell {
    private func setCollectionView() {

        collectionView.delegate = self
        collectionView.dataSource = self

        setCollectionViewLayout()
    }

    private func setCollectionViewLayout() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 163, height: 125)
            flowLayout.minimumInteritemSpacing = 8
        }
    }
}

extension YoutuberPopularVideoTableViewCell {
    func configure(_ videos: [Video]) {
        self.videos = videos

        collectionView.reloadData()
    }

    private func playInYoutube(youtubeId: String) {
        if let youtubeURL = URL(string: "youtube://\(youtubeId)"),
            UIApplication.shared.canOpenURL(youtubeURL) {
            // redirect to app
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(youtubeId)") {
            // redirect through safari
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }
    }

}

extension YoutuberPopularVideoTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        playInYoutube(youtubeId: videos[indexPath.row].youtubeVideoId)
        delegate?.goToPlayer(videos[indexPath.row].youtubeVideoId)
    }
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
