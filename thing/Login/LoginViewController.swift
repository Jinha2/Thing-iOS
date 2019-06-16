//
//  LoginViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/14.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAnalytics

class LoginViewController: UIViewController {
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
}

extension LoginViewController {
    func checkLogin() {
        if FirebaseLayer.isUserSignedIn() {
            Analytics.logEvent(AnalyticsEventLogin, parameters: [
                AnalyticsParameterMethod: method
            ])
            dismiss(animated: true, completion: nil)
        }
    }

    func setUpGoogleLogin() {
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
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
