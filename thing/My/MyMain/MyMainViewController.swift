//
//  MyMainViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class MyMainViewController: UIViewController {
    var isLikeSelected: Bool = true
    var lastSelectedButton: UIButton?
    @IBOutlet weak var tableView: UITableView!

    @IBAction func likeButtonAction(_ sender: UIButton) {
        isLikeSelected = true
        sender.isSelected = true
        if sender != lastSelectedButton {
            lastSelectedButton?.isSelected = false
            tableView.reloadData()
        }
        lastSelectedButton = sender
    }
    @IBAction func dislikeButtonAction(_ sender: UIButton) {
        isLikeSelected = false
        sender.isSelected = true
        if sender != lastSelectedButton {
            lastSelectedButton?.isSelected = false
            tableView.reloadData()
        }
        lastSelectedButton = sender
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MyMainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyMainCommentTableViewCell", for: indexPath) as? MyMainCommentTableViewCell else { return UITableViewCell() }
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension MyMainViewController: CommentReportDelegate {
    func moreButtonTouchAction(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "신고", style: .destructive, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in }))

        present(alert, animated: true)
    }
}
