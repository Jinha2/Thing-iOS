//
//  LoginViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/14.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setUpGoogleLogin()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        checkLogin()
    }

    @IBAction private func loginButtonAction(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        showActivityIndicator()

        FirebaseLayer.loginUser(email: email, password: password) { [weak self] result in
            Log(result?.user.displayName)
            hideActivityIndicator()
            self?.checkLogin()
        }
    }
}

extension LoginViewController {
    func checkLogin() {
        if FirebaseLayer.isUserSignedIn() {
            if let displayName = FirebaseLayer.getDisplayName(), displayName != "" {
                dismiss(animated: true, completion: nil)
            } else {
                showUpdateProfileViewController()
            }
        }
    }

    func setUpGoogleLogin() {
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    func showUpdateProfileViewController() {
        guard let updateProfileViewController = storyboard?.instantiateViewController(withIdentifier: "UpdateProfileViewController") else { return }
        present(updateProfileViewController, animated: true, completion: nil)
    }
}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        showActivityIndicator()

        FirebaseLayer.sign(signIn, user, error) { [weak self] result in
            Log(result)
            hideActivityIndicator()
            self?.checkLogin()
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
}
