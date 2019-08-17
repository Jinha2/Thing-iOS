//
//  AddTagViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/08/06.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import Tags

final class AddTagViewController: UIViewController {
    @IBOutlet weak var commontagsView: TagsView!
    @IBOutlet weak var categoryTagsView: TagsView!

    private let tags = [Tags]()

    override func viewDidLoad() {
        super.viewDidLoad()

        commontagsView.delegate = self
        categoryTagsView.delegate = self

        requestTags()
    }

    @IBAction private func completeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddTagViewController {
    private func requestTags() {
        ThingProvider.tags(completion: { tags in
            defer {
                self.commontagsView.redraw()
                self.categoryTagsView.redraw()
            }

            let normalOptions = ButtonOptions(
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

            for tag in tags.tags {

                if tag.category == "공통" {
                    for title in tag.list {
                        let tagButton = TagButton()

                        tagButton.setTitle(title, for: .normal)
                        tagButton.setEntity(selectedOptions)

                        self.commontagsView.append(tagButton)
                    }
                } else {
                    let tagButton = TagButton()

                    tagButton.setTitle(tag.category, for: .normal)
                    tagButton.setEntity(normalOptions)

                    self.categoryTagsView.append(tagButton)
                }
            }
        }) { error in
            Log(error)
        }
    }
}

extension AddTagViewController: TagsDelegate {
    func tagsTouchAction(_ tagsView: TagsView, tagButton: TagButton) {
        print(tagButton)
    }
}
