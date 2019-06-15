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
    @IBOutlet weak var googleSignInButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpGoogleLogin()
    }
}

extension LoginViewController {
    func setUpGoogleLogin() {
        GIDSignIn.sharedInstance().uiDelegate = self
    }
}

extension LoginViewController: GIDSignInUIDelegate {
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        Log(signIn)
    }
}
