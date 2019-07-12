//
//  CategoryCollectionViewCell.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedLineView: UIView!

    override var isSelected: Bool {
        didSet {
            categorySelected()
        }
    }

    private func reset() {
        titleLabel.text = nil
        selectedLineView.isHidden = true
    }

    func contents(_ model: CategoryList) {
        reset()

        titleLabel.text = model.categoryType
    }

    func categorySelected() {
        selectedLineView.isHidden = isSelected == true ? false : true
    }
}
