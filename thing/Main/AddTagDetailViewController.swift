//
//  AddTagDetailViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/08/17.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

final class AddTagDetailViewController: UIViewController {

    @IBOutlet weak var tagTableView: UITableView!

    var tags: [Tag]?
    var commonTags: TagCell?
    var categoryTags = [TagCell]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true

//        tagCellModel()
    }

    @IBAction private func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func completeButtonAction(_ sender: Any) {
        requestAddTag()
    }
}

extension AddTagDetailViewController {
//    private func tagCellModel() {
//        guard let tags = tags else { return }
//
//        for tag in tags {
//            var tagList = [TagList]()
//
//            for list in tag.list {
//                tagList.append(TagList(title: list, isSelected: false))
//            }
//
//            categoryTags.append(TagCell(category: tag.category, list: tagList))
//        }
    //
    //        tagTableView.reloadData()
    //    }
    //

    private func requestAddTag() {
        guard let commonTags = commonTags else { return }
        showActivityIndicator()

        let commonTitles = commonTags.list.filter { $0.isSelected }.map { $0.title }
        let categoryTitles = categoryTags.flatMap { $0.list.filter { $0.isSelected }.map { $0.title } }

        ThingProvider.addTag(category: categoryTitles, common: commonTitles, completion: { [weak self] home in
            hideActivityIndicator()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homeRequest"), object: home)
            self?.dismiss(animated: true, completion: nil)
        }) { error in
            hideActivityIndicator()
            presentErrorAlert(error: error)
        }
    }
}

extension AddTagDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryTags.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TagTableViewCell") as? TagTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        cell.contents(tag: categoryTags[indexPath.row])

        return cell
    }
}

extension AddTagDetailViewController: TagTableViewCellDelegate {
    func didSelectTag(_ cell: TagTableViewCell, tagIndex: Int) {
        guard let indexPath = tagTableView.indexPath(for: cell) else { return }

        categoryTags[indexPath.row].list[tagIndex].didSelect()
    }
}
