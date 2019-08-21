//
//  MainViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private var isFirstView: Bool = true
    private var home: Home?

    @IBOutlet weak var recommendTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        recommendTableView.register(UINib(nibName: "EmptyTagsTableViewCell", bundle: .main), forCellReuseIdentifier: "EmptyTagsTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !FirebaseLayer.isUserSignedIn() {
            showLoginView()
            isFirstView = true
        } else {
            if isFirstView {
                requestLogin()
                isFirstView = false
            }
        }
    }
}

extension MainViewController {
    private func requestLogin() {
        showActivityIndicator()
        ThingProvider.signIn(completion: { [weak self] user in
            UserInstance.setUser(user: user)
            ThingProvider.home(completion: { home in
                hideActivityIndicator()
                self?.home = home
                self?.recommendTableView.reloadData()
            }, failure: { error in
                hideActivityIndicator()
                presentErrorAlert(error: error)
            })
        }) { [weak self] error in
            hideActivityIndicator()
            if (error as NSError).code == 4301 {
                self?.showUpdateProfileViewController()
            } else {
                presentErrorAlert(error: error)
            }
        }
    }

    private func requestHome() {
        ThingProvider.home(completion: { recommend in
            print(recommend)
        }) { error in
            print(error)
        }
    }

    private func showLoginView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewContoller = storyboard.instantiateViewController(withIdentifier: "HiddenNavigationViewController")
        present(loginViewContoller, animated: true, completion: nil)
    }

    private func showUpdateProfileViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let updateProfileViewController = storyboard.instantiateViewController(withIdentifier: "UpdateProfileViewController")
        present(updateProfileViewController, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 {
            guard let vc = UIStoryboard(name: "EndPage", bundle: nil).instantiateViewController(withIdentifier: "EndPageViewController") as? EndPageViewController else { return }
            vc.id = home?.soaringYouTuber?[indexPath.row].id
            present(vc, animated: true, completion: nil)
        } else if indexPath.section == 5 {
            guard let vc = UIStoryboard(name: "EndPage", bundle: nil).instantiateViewController(withIdentifier: "EndPageViewController") as? EndPageViewController else { return }
            vc.id = home?.recommendedYouTuber?[indexPath.row].id
            present(vc, animated: true, completion: nil)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard home != nil else { return 0 }
        guard home?.recommendedYouTuber?.count != 0 else { return 1 }
        return 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard home != nil else { return 0 }
        guard home?.recommendedYouTuber?.count != 0 else { return 1 }
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return home?.soaringYouTuber?.count ?? 0
        } else if section == 4 {
            return 1
        }
        return home?.recommendedYouTuber?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard home != nil else { return 0 }
        guard home?.recommendedYouTuber?.count != 0 else { return tableView.bounds.height }

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard home != nil else { return .init() }
        if home?.recommendedYouTuber?.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTagsTableViewCell", for: indexPath) as? EmptyTagsTableViewCell else { return .init() }
            cell.delegate = self
            cell.reloadCell()
            return cell
        } else {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTitleTableViewCell", for: indexPath) as? RecommendTitleTableViewCell else { return .init() }
                cell.setModel(model: home?.recommendedYouTuber)
                cell.delegate = self
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendFooterTableViewCell", for: indexPath)
                return cell
            } else if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SoaringYoutuberHeaderTableViewCell", for: indexPath)
                return cell
            } else if indexPath.section == 3 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "SoaringYouTuberTableViewCell", for: indexPath) as? SoaringYouTuberTableViewCell else { return .init() }
                cell.setModel(model: home?.soaringYouTuber?[indexPath.row])
                return cell
            } else if indexPath.section == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendFooterTableViewCell", for: indexPath)
                return cell
            } else if indexPath.section == 5 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendYoutuberTableViewCell", for: indexPath) as? RecommendYoutuberTableViewCell else { return .init() }
                cell.setModel(model: home?.recommendedYouTuber?[indexPath.row])
                cell.delegate = self
                return cell
            }

            return .init()
        }
    }
}

extension MainViewController: EmptyTagsTableViewCellDelegate {
    func addTagButtonAction() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTagViewController")

        present(viewController, animated: true, completion: nil)
    }
}

extension MainViewController: YoutuberPopularVideoTableViewCellDelegate {
    func goToPlayer(_ id: String) {
        let vc = YoutubePlayerViewController.newViewController(id: id)
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: RecommendTitleCollectionViewCellSelectDelegate {
    func openYoutuber(_ id: Int) {
        guard let vc = UIStoryboard(name: "EndPage", bundle: nil).instantiateViewController(withIdentifier: "EndPageViewController") as? EndPageViewController else { return }
        vc.id = id
        present(vc, animated: true, completion: nil)
    }
}
