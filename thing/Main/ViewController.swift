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
        let loginViewContoller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(loginViewContoller, animated: true, completion: nil)
    }
}
