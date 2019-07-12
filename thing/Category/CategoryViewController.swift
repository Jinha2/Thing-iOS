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

    private var filter = "TOTAL"
    private var nextPage: Int?
    private var rankings = [RankingList]()

    let category = ["일상", "오버워치", "엔터테이먼트", "ASMR", "뷰티", "졸료요", "P곤!"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = CGSize(width: 50, height: 50)
        layout?.itemSize = UICollectionViewFlowLayout.automaticSize

        setCategory()
    }

    func setCategory() {

        categoryCollectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async {
            self.categoryCollectionView.collectionViewLayout.invalidateLayout()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        categoryCollectionView.collectionViewLayout.invalidateLayout()
    }

    @IBAction private func filterButtonAction(_ sender: Any) {
        showSortAlert()
    }
}

extension CategoryViewController {
    func requestRankings(filter: String, page: Int) {
        if page == 0 {
            rankings.removeAll()
        }

        ThingProvider().rankings(filter: filter, page: page, completion: { data in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let rankings = try decoder.decode(Rankings.self, from: data)

                self.nextPage = rankings.nextPage

                for ranking in rankings.rankings {
                    self.rankings.append(ranking)
                }

                self.rankingTableView.reloadData()
            } catch {}
        }) { _ in

        }
    }

    func showSortAlert() {
        let alert = UIAlertController(title: "정렬 방식", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "구독자순", style: .default, handler: { _ in
//            self.filterTitleLabel.text = "유튜브 구독자 랭킹"
            self.requestRankings(filter: "TOTAL", page: 0)
        }))
        alert.addAction(UIAlertAction(title: "급상승순", style: .default, handler: { _ in
//            self.filterTitleLabel.text = "유튜브 급상승 랭킹"
            self.requestRankings(filter: "SOARING", page: 0)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in }))

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

        present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == rankings.count - 1 else { return }
        guard let nextPage = nextPage else { return }

        requestRankings(filter: filter, page: nextPage)
    }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell

        cell.selectedLineView.isHidden = true
        cell.titleLabel.text = category[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        rankingTableView.reloadData()
    }
}
