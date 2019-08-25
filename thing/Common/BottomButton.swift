//
//  BottomButton.swift
//  thing
//
//  Created by Jinha Park on 2019/08/26.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class BottomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        titleEdgeInsets.bottom = frame.height - 60
    }
}
