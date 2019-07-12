//
//  CategoryViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var rankingTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!

    private var filter = "TOTAL"
    private var nextPage: Int?
    private var rankings = [RankingList]()
    private var categories = [CategoryList]()
    private var isFirstView: Bool = true
    private var categoryId = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = CGSize(width: 50, height: 50)
        layout?.itemSize = UICollectionViewFlowLayout.automaticSize

        setCategory()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async {
            self.categoryCollectionView.collectionViewLayout.invalidateLayout()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if isFirstView {
            categoryCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
            requestRankings(categoryId: categories[0].id, filter: filter, page: 0)
            isFirstView = false
        }

        categoryCollectionView.collectionViewLayout.invalidateLayout()
    }

    @IBAction private func filterButtonAction(_ sender: Any) {
        showSortAlert()
    }
}

extension CategoryViewController {
    func setCategory() {
        guard let category = Category.sharedInstance.categories else { return }

        categories = category
        categoryCollectionView.reloadData()
    }

    func requestRankings(categoryId: Int, filter: String, page: Int) {
        if page == 0 {
            rankings.removeAll()
            rankingTableView.reloadData()
        }

        showActivityIndicator()

        ThingProvider().categories(categoryId: categoryId, filter: filter, page: page, completion: { data in
            defer {
                hideActivityIndicator()
                self.rankingTableView.reloadData()
            }

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let rankings = try decoder.decode(Rankings.self, from: data)

                self.nextPage = rankings.nextPage

                for ranking in rankings.rankings {
                    self.rankings.append(ranking)
                }
            } catch {}
        }) { _ in

        }
    }

    func showSortAlert() {
        let alert = UIAlertController(title: "정렬 방식", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "구독자순", style: .default, handler: { _ in
//            self.filterTitleLabel.text = "유튜브 구독자 랭킹"
            self.requestRankings(categoryId: self.categoryId, filter: "TOTAL", page: 0)
        }))
        alert.addAction(UIAlertAction(title: "급상승순", style: .default, handler: { _ in
//            self.filterTitleLabel.text = "유튜브 급상승 랭킹"
            self.requestRankings(categoryId: self.categoryId, filter: "SOARING", page: 0)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in }))

        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = filterButton
            popoverController.sourceRect = CGRect(x: filterButton.bounds.midX, y: filterButton.bounds.maxY, width: 0, height: 0)
        }
        present(alert, animated: true)
    }
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
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

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell

        cell.contents(categories[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        requestRankings(categoryId: categories[indexPath.row].id, filter: filter, page: 0)
    }
}
