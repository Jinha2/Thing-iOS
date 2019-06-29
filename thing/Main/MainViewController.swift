//
//  MainViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        checkLogin()
    }

    @IBAction private func signOut(_ sender: Any) {
        FirebaseLayer.signOut()
        checkLogin()
    }
}

extension MainViewController {
    func checkLogin() {
        if !FirebaseLayer.isUserSignedIn() {
            showLoginView()
        }
    }

    func showLoginView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewContoller = storyboard.instantiateViewController(withIdentifier: "HiddenNavigationViewController")
        present(loginViewContoller, animated: true, completion: nil)
    }

    func showSortAlert() {
        let alert = UIAlertController(title: "정렬 방식", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "구독자순", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "급상승순", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in }))

        present(alert, animated: true)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YouTubeTableViewCell", for: indexPath) as! YoutubeTableViewCell

        return cell
    }
}
