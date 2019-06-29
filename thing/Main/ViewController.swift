//
//  ViewController.swift
//  thing
//
//  Created by 이호찬 on 10/06/2019.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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

extension ViewController {
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
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YouTubeTableViewCell", for: indexPath) as! YouTubeTableViewCell

        return cell
    }
}
