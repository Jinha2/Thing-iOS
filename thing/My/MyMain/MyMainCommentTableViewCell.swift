//
//  MyMainCommentTableViewCell.swift
//  thing
//
//  Created by 이재성 on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

protocol CommentReportDelegate: class {
    func moreButtonTouchAction(_ indexPath: IndexPath?)
}
class MyMainCommentTableViewCell: UITableViewCell {
    var indexPath: IndexPath?
    weak var delegate: CommentReportDelegate?
    @IBAction func moreButtonTouchAction(_ sender: UIButton) {
        delegate?.moreButtonTouchAction(indexPath)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
