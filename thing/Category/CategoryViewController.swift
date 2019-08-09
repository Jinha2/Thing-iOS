//
//  CategoryViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import SegementSlide

class CategoryViewController: SegementSlideViewController {
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    private var categories: [CategoryList] {
        return UserInstance.getUser()?.categories ?? []
    }
    override var titlesInSwitcher: [String] {
        let categoryString = categories.map { $0.categoryType }
        return categoryString
    }
    override var headerView: UIView? {
        return CategoryHeaderView.loadFromXib()
    }
    override var headerHeight: CGFloat? {
        return 64
    }
    override var headerStickyHeight: CGFloat {
        return 0
    }
    override var switcherConfig: SegementSlideSwitcherConfig {
        let config = SegementSlideSwitcherConfig(underlineType: .corner,
                                                 normalTitleFont: .boldSystemFont(ofSize: 15),
                                                 selectedTitleFont: .boldSystemFont(ofSize: 15),
                                                 normalTitleColor: UIColor(named: "brownGrey") ?? .black,
                                                 selectedTitleColor: .black,
                                                 indicatorColor: UIColor(named: "MainRed") ?? .red)
        return config
    }
    override var bouncesType: BouncesType {
        return .child
    }

    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        guard let categoryContentViewController: CategoryContentViewController = storyboard?.instantiateViewController(withIdentifier: "CategoryContentViewController") as? CategoryContentViewController else { return nil }
        categoryContentViewController.categoryId = categories[index].id
        return categoryContentViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData()
        scrollToSlide(at: 0, animated: false)
    }

    @IBAction private func filterButtonAction(_ sender: Any) {
//        showSortAlert()
    }
}

extension CategoryViewController {
    //    func showSortAlert() {
    //        let alert = UIAlertController(title: "정렬 방식", message: nil, preferredStyle: .actionSheet)
    //        alert.addAction(UIAlertAction(title: "구독자순", style: .default, handler: { _ in
    ////            self.filterTitleLabel.text = "유튜브 구독자 랭킹"
    //            self.requestRankings(categoryId: self.categoryId, filter: "TOTAL", page: 0)
    //        }))
    //        alert.addAction(UIAlertAction(title: "급상승순", style: .default, handler: { _ in
    ////            self.filterTitleLabel.text = "유튜브 급상승 랭킹"
    //            self.requestRankings(categoryId: self.categoryId, filter: "SOARING", page: 0)
    //        }))
    //        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in }))
    //
    //        if let popoverController = alert.popoverPresentationController {
    //            popoverController.sourceView = filterButton
    //            popoverController.sourceRect = CGRect(x: filterButton.bounds.midX, y: filterButton.bounds.maxY, width: 0, height: 0)
    //        }
    //        present(alert, animated: true)
    //    }
}
