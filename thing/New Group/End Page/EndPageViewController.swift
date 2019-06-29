//
//  EndPageViewController.swift
//  thing
//
//  Created by 이호찬 on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class EndPageViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction private func dismissTouchUpInsideAction(_ sender: UIButton) {

    }

}

extension EndPageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 3: //3,4 는 한줄평 섹션
            return 1 // 수정
        case 4:
            return 1 // 수정
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return youtuberInfoCell(tableView, cellForRowAt: indexPath)
            } else {
                return youtuberDescriptionCell(tableView, cellForRowAt: indexPath)
            }
        case 1:
            return youtuberPopularVideoCell(tableView, cellForRowAt: indexPath)
        case 2:
            return oneLineReviewTitleCell(tableView, cellForRowAt: indexPath)
        default:
            return .init()
        }
    }
}

extension EndPageViewController {
    func youtuberInfoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YoutuberInfoTableViewCell", for: indexPath) as? YoutuberInfoTableViewCell else { return .init() }

        return cell
    }

    func youtuberDescriptionCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YoutuberDescriptionTableViewCell", for: indexPath) as? YoutuberDescriptionTableViewCell else { return .init() }

        return cell
    }

    func youtuberPopularVideoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YoutuberPopularVideoTableViewCell", for: indexPath) as? YoutuberPopularVideoTableViewCell else { return .init() }

        return cell
    }

    func oneLineReviewTitleCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OneLineReviewTitleTableViewCell", for: indexPath) as? OneLineReviewTitleTableViewCell else { return .init() }

        return cell
    }

}

extension EndPageViewController: UITableViewDelegate {

}
