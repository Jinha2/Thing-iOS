//
//  EmptyTagsTableViewCell.swift
//  thing
//
//  Created by Jinha Park on 2019/08/06.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
protocol EmptyTagsTableViewCellDelegate: class {
    func addTagButtonAction()
}

class EmptyTagsTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    weak var delegate: EmptyTagsTableViewCellDelegate?

    func reloadCell() {
        guard let nickname = UserInstance.getUser()?.nickName else { return }

        descriptionLabel.text = "\(nickname)의 취향에 적합한 유튜버를 추천해드립니다."
    }

    @IBAction private func addTagButtonAction(_ sender: Any) {
        delegate?.addTagButtonAction()
    }
}
