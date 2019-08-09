//
//  CategoryContentViewController.swift
//  thing
//
//  Created by JERCY on 09/08/2019.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import SegementSlide

class CategoryContentViewController: UIViewController, SegementSlideContentScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var rankings = [RankingList]()
    private var nextPage: Int?
    private var isFirstView: Bool = true
    var categoryId = 1
    private var filter = "TOTAL"

    @objc var scrollView: UIScrollView {
        return tableView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if isFirstView {
            requestRankings(categoryId: categoryId, filter: filter, page: 0)
            isFirstView = false
        }
    }

}

extension CategoryContentViewController {
    func requestRankings(categoryId: Int, filter: String, page: Int) {
        if page == 0 {
            rankings.removeAll()
        }

        showActivityIndicator()

        ThingProvider.categories(categoryId: categoryId, filter: filter, page: page, completion: { [weak self] rankings in
            self?.nextPage = rankings.nextPage

            rankings.rankings.forEach {
                self?.rankings.append($0)
            }

            hideActivityIndicator()
            self?.tableView.reloadData()
        }) { error in
            presentErrorAlert(error: error)
        }
    }
}

extension CategoryContentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YoutubeTableViewCell", for: indexPath) as! YoutubeTableViewCell

        cell.contents(rankings[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "EndPage", bundle: nil).instantiateViewController(withIdentifier: "EndPageViewController") as? EndPageViewController else { return }

        vc.id = rankings[indexPath.row].id
        present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == rankings.count - 1 else { return }
        guard let nextPage = nextPage else { return }

        requestRankings(categoryId: categoryId, filter: filter, page: nextPage)
    }
}
