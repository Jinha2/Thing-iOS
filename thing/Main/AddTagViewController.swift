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

    private var allTags: Tags?
    private var subTags: TagCell?
    private var commonCategoryList: TagCell?

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

        let titles = subTags?.list.filter { $0.isSelected }.map { $0.title }
        var selectedTags: [TagCell] = []
        allTags?.tags.forEach {
            if titles?.contains($0.category) ?? false {
                var tagList: [TagList] = []
                $0.list.forEach { list in
                    tagList.append(TagList(title: list, isSelected: false))
                }
                selectedTags.append(TagCell(category: $0.category, list: tagList))
            }
        }

        if selectedTags.count == 0 {
            presentAlert(msg: "관심카테고리를 최소 1개이상 선택해주세요.")
            return
        }
        addTagDetailViewController.categoryTags = selectedTags
        addTagDetailViewController.commonTags = commonCategoryList
        navigationController?.pushViewController(addTagDetailViewController, animated: true)
    }
}

extension AddTagViewController {
    private func requestTags() {
        ThingProvider.tags(completion: { [weak self] tags in
            self?.allTags = tags
            var categoryList = [TagList]()
            for tag in tags.tags {
                if tag.category == "공통" {
                    var tagList = [TagList]()

                    for list in tag.list {
                        tagList.append(TagList(title: list, isSelected: false))
                    }
                    self?.commonCategoryList = TagCell(category: nil, list: tagList)
                } else {
                    categoryList.append(TagList(title: tag.category, isSelected: false))
                }
            }
            self?.subTags = TagCell(category: "관심 카테고리", list: categoryList)
            self?.tagTableView.reloadData()
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
        if indexPath.row == 0 {
            cell.contents(tag: commonCategoryList)
        } else if indexPath.row == 1 {
            cell.contents(tag: subTags)
        }

        return cell
    }
}

extension AddTagViewController: TagTableViewCellDelegate {
    func didSelectTag(_ cell: TagTableViewCell, tagIndex: Int) {
        guard let indexPath = tagTableView.indexPath(for: cell) else { return }

        if indexPath.row == 0 {
            commonCategoryList?.list[tagIndex].didSelect()
        } else {
            subTags?.list[tagIndex].didSelect()
        }
    }
}
