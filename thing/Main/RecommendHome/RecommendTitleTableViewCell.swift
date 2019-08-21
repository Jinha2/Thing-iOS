//
//  RecommendTitleTableViewCell.swift
//  thing
//
//  Created by 이재성 on 2019/08/21.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

protocol RecommendTitleCollectionViewCellSelectDelegate: class {
    func openYoutuber(_ id: Int)
}

class RecommendTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    weak var delegate: RecommendTitleCollectionViewCellSelectDelegate?

    private var model: [Recommend]? {
        didSet {

            if let nickname = UserInstance.getUser()?.nickName {
                titleLabel.text = """
                \(nickname)님,
                이런 유튜버 찾아다니셨죠?
                """
            }
            collectionView.reloadData()
        }
    }

    func setModel(model: [Recommend]?) {
        self.model = model
    }
}

extension RecommendTitleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = model?[indexPath.row].id else { return }
        delegate?.openYoutuber(id)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendTitleCollectionViewCell", for: indexPath) as? RecommendTitleCollectionViewCell else { return .init() }
        cell.setModel(model: model?[indexPath.row])
        return cell
    }
}
