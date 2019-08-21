//
//  RecommendTitleTableViewCell.swift
//  thing
//
//  Created by 이재성 on 2019/08/21.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class RecommendTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    private var model: [Recommend]? {
        didSet {
            collectionView.reloadData()
        }
    }

    func setModel(model: [Recommend]?) {
        self.model = model
    }
}

extension RecommendTitleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendTitleCollectionViewCell", for: indexPath) as? RecommendTitleCollectionViewCell else { return .init() }
        cell.setModel(model: model?[indexPath.row])
        return cell
    }
}
