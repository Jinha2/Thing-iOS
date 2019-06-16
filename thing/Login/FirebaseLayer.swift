//
//  FirebaseLayer.swift
//  thing
//
//  Created by 이재성 on 2019/06/16.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

struct FirebaseLayer {
    static func isUserSignedIn() -> Bool {
        guard Auth.auth().currentUser != nil else { return false }
        return true
    }

    static func sign(_ signIn: GIDSignIn!, _ user: GIDGoogleUser!, _ error: Error?, completion: @escaping ((AuthDataResult?) -> Void)) {
        if let error = error {
            presentErrorAlert(error: error)
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                presentErrorAlert(error: error)
                return
            }
            completion(result)
        }
    }

    static func getUid() {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { result, error in
            if error != nil {
                presentErrorAlert(error: error)
                return
            }

            Log(result)
        })
    }

    static func loginUser(email: String, password: String, completion: @escaping ((AuthDataResult?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                presentErrorAlert(error: error)
                return
            }

            completion(result)
        }
    }

    static func createUser(email: String, password: String, completion: @escaping ((AuthDataResult?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                if (error as NSError?)?.code == 17007 {
                    presentAlert(msg: "이미 가입된 이메일 입니다")
                } else {
                    presentErrorAlert(error: error)
                }
                return
            }

            completion(result)
        }
    }

    static func changeUser(displayName: String?) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { error in
            presentErrorAlert(error: error)
        }
    }

    static func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let error {
            presentErrorAlert(error: error)
        }
    }
}
