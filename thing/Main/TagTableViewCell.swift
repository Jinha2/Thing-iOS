//
//  TagTableViewCell.swift
//  thing
//
//  Created by Jinha Park on 2019/08/17.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import Tags

protocol TagTableViewCellDelegate: class {
    func didSelectTag(_ cell: TagTableViewCell, tagIndex: Int)
}

final class TagTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsView: TagsView!

    weak var delegate: TagTableViewCellDelegate?

    let normalOptions = ButtonOptions(
        layerColor: .clear,
        layerRadius: 20,
        layerWidth: 0,
        tagTitleColor: UIColor(named: "background")!,
        tagFont: UIFont.systemFont(ofSize: 16, weight: .medium),
        tagBackgroundColor: UIColor(named: "boxBackground")!
    )

    let selectedOptions = ButtonOptions(
        layerColor: UIColor(named: "MainRed")!,
        layerRadius: 20,
        layerWidth: 1.5,
        tagTitleColor: UIColor(named: "MainRed")!,
        tagFont: UIFont.systemFont(ofSize: 16, weight: .medium)
    )

    private func reset() {
        titleLabel.text = nil
        tagsView.removeAll()
    }

    func contents(tag: TagCell) {
        reset()

        if titleLabel != nil {
            titleLabel.text = tag.category
        }

        tagsView.delegate = self
        tagsView.removeAll()

        let tags = tag.list.enumerated().map ({ list -> TagButton in
            let tagButton = TagButton()
            tagButton.setTitle(list.element.title, for: .normal)
            tagButton.setEntity(list.element.isSelected == true ? selectedOptions : normalOptions)
            return tagButton
        })

        tagsView.append(contentsOf: tags)
        tagsView.redraw()
    }
}

extension TagTableViewCell: TagsDelegate {
    func tagsTouchAction(_ tagsView: TagsView, tagButton: TagButton) {
        tagButton.isSelected = !tagButton.isSelected
        tagButton.setEntity(tagButton.isSelected == true ? selectedOptions : normalOptions)
        tagsView.redraw()

        delegate?.didSelectTag(self, tagIndex: tagsView.tagArray.firstIndex(of: tagButton)!)
    }
}
