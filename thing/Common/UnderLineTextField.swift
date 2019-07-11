//
//  UnderLineTextField.swift
//  thing
//
//  Created by Jinha Park on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

@IBDesignable
class UnderLineTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()

        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension UnderLineTextField {
    func commonInit() {
        let underLine = CALayer()

        underLine.backgroundColor = UIColor(named: "veryLightPink")?.cgColor
        underLine.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1)

        borderStyle = .none
        layer.addSublayer(underLine)
    }
}
