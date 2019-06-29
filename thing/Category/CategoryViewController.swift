//
//  CategoryViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var youtubeRankTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!

    let category = ["일상", "오버워치", "엔터테이먼트", "ASMR", "뷰티", "졸료요", "P곤!"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = CGSize(width: 50, height: 50)
        layout?.itemSize = UICollectionViewFlowLayout.automaticSize
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
    func showSortAlert() {
        let alert = UIAlertController(title: "정렬 방식", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "구독자순", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "급상승순", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in }))

        present(alert, animated: true)
    }
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YoutubeTableViewCell", for: indexPath) as! YoutubeTableViewCell

        return cell
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

        cell.selectedLineView.isHidden = false

        collectionView.reloadData()
//        youtubeRankTableView.reloadData()
    }
}
