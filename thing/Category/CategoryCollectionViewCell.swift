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
    
    private func reset() {
        self.titleLabel.text = nil
        self.selectedLineView.isHidden = true
    }
    
    
}
