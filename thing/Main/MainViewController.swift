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
                isFirstView = false
            }
        }
    }
}

extension MainViewController {
    private func requestLogin() {
        showActivityIndicator()
        ThingProvider.signIn(completion: { user in
            hideActivityIndicator()
            UserInstance.setUser(user: user)
        }) { [weak self] error in
            hideActivityIndicator()
            if (error as NSError).code == 4002 {
                self?.showUpdateProfileViewController()
            } else {
                presentErrorAlert(error: error)
            }
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
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
