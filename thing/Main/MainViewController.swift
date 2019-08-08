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
    private var recommend: [Recommend]?

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
            hideActivityIndicator()
            UserInstance.setUser(user: user)
            self?.recommendTableView.reloadData()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recommend = recommend else { return 1 }

        return recommend.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard recommend != nil else { return tableView.bounds.height }

        return 202
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if recommend == nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTagsTableViewCell", for: indexPath) as? EmptyTagsTableViewCell else { return .init() }
            cell.delegate = self
            cell.reloadCell()
            return cell
        } else {
            let cell = UITableViewCell()
            return cell
        }
    }
}

extension MainViewController: EmptyTagsTableViewCellDelegate {
    func addTagButtonAction() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTagViewController")

        navigationController?.present(viewController, animated: true, completion: nil)
    }
}
