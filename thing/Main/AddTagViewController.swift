//
//  AddTagViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/08/06.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

final class AddTagViewController: UIViewController {

    @IBOutlet weak var tagTableView: UITableView!

    private var tags = [TagCell]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        requestTags()
    }

    @IBAction private func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func nextButtonAction(_ sender: Any) {
        guard let addTagDetailViewController: AddTagDetailViewController = storyboard?.instantiateViewController(withIdentifier: "AddTagDetailViewController") as? AddTagDetailViewController else { return }

        addTagDetailViewController.categoryTags = tags
        navigationController?.pushViewController(addTagDetailViewController, animated: true)
    }
}

extension AddTagViewController {
    private func requestTags() {
        ThingProvider.tags(completion: { tags in
            for tag in tags.tags {
                if tag.category == "공통" {

                } else {
                    var tagList = [TagList]()

                    for list in tag.list {
                        tagList.append(TagList(title: list, isSelected: false))
                    }

                    self.tags.append(TagCell(category: tag.category, list: tagList))
                }
            }
        }) { error in
            Log(error)
        }
    }
}

extension AddTagViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TagTableViewCell") as? TagTableViewCell else { return UITableViewCell() }

        cell.delegate = self
//        cell.contents(tag: categoryTags[indexPath.row])

        return cell
    }
}

extension AddTagViewController: TagTableViewCellDelegate {
    func didSelectTag(_ cell: TagTableViewCell, tagIndex: Int) {
        guard let indexPath = tagTableView.indexPath(for: cell) else { return }

//        categoryTags[indexPath.row].list[tagIndex].didSelect()
    }
}
