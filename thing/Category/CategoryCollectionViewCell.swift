//
//  CategoryCollectionViewCell.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
protocol CategoryCollectionViewCellDelegate: class {
    func changeCategory(_ id: Int)
}

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedLineView: UIView!

    let id: Int?
    
    weak var delegate: CategoryCollectionViewCellDelegate?
    
    override var isSelected: Bool {
        didSet {
            categorySelected()
        }
    }

    private func reset() {
        titleLabel.text = nil
        selectedLineView.isHidden = true
    }

    func contents(_ model: Category) {
        reset()
        
        id = model.id
        titleLabel.text = model.categoryType
    }

    func categorySelected() {
        guard let id = id else { return }
        selectedLineView.isHidden = isSelected == true ? false : true
        
        delegate?.changeCategory(id)
    }
}
