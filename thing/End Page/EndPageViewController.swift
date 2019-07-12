//
//  EndPageViewController.swift
//  thing
//
//  Created by 이호찬 on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import Kingfisher

class EndPageViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var id: Int?
    var youtuber: Youtuber?

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()

        guard let id = id else { return }
        requestYoutuber(id: id)
    }

    @IBAction private func dismissTouchUpInsideAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

extension EndPageViewController {
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        let topInset = UIScreen.main.bounds.width * 0.3
        tableView.contentInset = .init(top: topInset, left: 0, bottom: 0, right: 0)
    }
}

extension EndPageViewController {
    func requestYoutuber(id: Int) {

        ThingProvider().youtuber(id: id, completion: { data in
            print(id)
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let youtuber = try decoder.decode(Youtuber.self, from: data)

                self.youtuber = youtuber
                self.setBannerImage()
            } catch { }
        }) { _ in

        }
    }

    func setBannerImage() {
        guard let youtuber = youtuber else { return }
        if let banner = youtuber.bannerImgUrl {
            let url = URL(string: banner)
            bannerImageView.kf.setImage(with: url)
        }
    }

}

extension EndPageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
//        case 3: //3,4 는 한줄평 섹션
//            return 1 // 수정
//        case 4:
//            return 1 // 수정
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
        case 3: // 좋아요
            if indexPath.row == 0 {
                return likeNumCell(tableView, cellForRowAt: indexPath)
            }
            return .init()
        case 4: // 싫어요
            if indexPath.row == 0 {
                return likeNumCell(tableView, cellForRowAt: indexPath)
            }
            return .init()

        default:
            return .init()
        }
    }
}

extension EndPageViewController {
    func youtuberInfoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YoutuberInfoTableViewCell", for: indexPath) as? YoutuberInfoTableViewCell else { return .init() }
             cell.configure(youtuber)

        return cell
    }

    func youtuberDescriptionCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YoutuberDescriptionTableViewCell", for: indexPath) as? YoutuberDescriptionTableViewCell else { return .init() }
        cell.configure(description: youtuber?.description)
        return cell
    }

    func youtuberPopularVideoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YoutuberPopularVideoTableViewCell", for: indexPath) as? YoutuberPopularVideoTableViewCell else { return .init() }
        cell.configure(youtuber?.videos ?? [])
        return cell
    }

    func likeNumCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikeNumTableViewCell", for: indexPath) as? LikeNumTableViewCell else { return .init() }

        cell.configure(indexPath: indexPath)

        return cell
    }

    func oneLineReviewTitleCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OneLineReviewTitleTableViewCell", for: indexPath) as? OneLineReviewTitleTableViewCell else { return .init() }

        return cell
    }

    func myMainCommentCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyMainCommentTableViewCell", for: indexPath) as? MyMainCommentTableViewCell else { return UITableViewCell() }
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }

}

extension EndPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EndPageViewController: CommentReportDelegate {
    func moreButtonTouchAction(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "신고", style: .destructive, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in }))

        present(alert, animated: true)
    }
}
