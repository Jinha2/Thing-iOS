//
//  MainViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var rankingTableView: UITableView!

    private var filter = "TOTAL"
    private var nextPage: Int?
    private var rankings = [RankingList]()
    private var isFirstView: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !FirebaseLayer.isUserSignedIn() {
            showLoginView()
        } else {
            if isFirstView {
                requestLogin()
                requestRankings(filter: filter, page: 0)
                isFirstView = false
            }
        }
    }

    @IBAction private func filterButtonAction(_ sender: Any) {
        showSortAlert()
    }
}

extension MainViewController {
    func requestLogin() {
        ThingProvider().signIn(completion: { data in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)

                Category.sharedInstance.categories = user.categories
            } catch {}
        }) { _ in

        }
    }

    func requestRankings(filter: String, page: Int) {
        if page == 0 {
            rankings.removeAll()
            rankingTableView.reloadData()
        }

        showActivityIndicator()

        ThingProvider().rankings(filter: filter, page: page, completion: { [weak self] data in
            defer {
                hideActivityIndicator()
                self?.rankingTableView.reloadData()
            }

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let rankings = try decoder.decode(Rankings.self, from: data)

                self?.nextPage = rankings.nextPage

                for ranking in rankings.rankings {
                    self?.rankings.append(ranking)
                }
            } catch {}
        }) { _ in

        }
    }

    func showLoginView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewContoller = storyboard.instantiateViewController(withIdentifier: "HiddenNavigationViewController")
        present(loginViewContoller, animated: true, completion: nil)
    }

    func showSortAlert() {
        let alert = UIAlertController(title: "정렬 방식", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "구독자순", style: .default, handler: { _ in
            self.filterTitleLabel.text = "유튜브 구독자 랭킹"
            self.requestRankings(filter: "TOTAL", page: 0)
        }))
        alert.addAction(UIAlertAction(title: "급상승순", style: .default, handler: { _ in
            self.filterTitleLabel.text = "유튜브 급상승 랭킹"
            self.requestRankings(filter: "SOARING", page: 0)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in }))

        present(alert, animated: true)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
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

        requestRankings(filter: filter, page: nextPage)
    }
}
