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

    static func getDisplayName() -> String? {
        return Auth.auth().currentUser?.displayName
    }

    static func sign(_ signIn: GIDSignIn!, _ user: GIDGoogleUser!, _ error: Error?, completion: @escaping ((AuthDataResult?) -> Void)) {
        if let error = error {
            presentErrorAlert(error: error)
            hideActivityIndicator()
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                presentErrorAlert(error: error)
                hideActivityIndicator()
                return
            }
            completion(result)
        }
    }

    static func getUid() -> String? {
        return Auth.auth().currentUser?.uid
    }

    static func loginUser(email: String, password: String, completion: @escaping ((AuthDataResult?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                if (error as NSError?)?.code == 17009 {
                    presentAlert(msg: "이메일 / 비밀번호가 틀립니다.")
                } else if (error as NSError?)?.code == 17008 {
                    presentAlert(msg: "이메일 형식을 확인해 주세요.")
                } else {
                    presentErrorAlert(error: error)
                }
                hideActivityIndicator()
                return
            }

            completion(result)
        }
    }

    static func createUser(email: String, password: String, completion: @escaping ((AuthDataResult?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                if (error as NSError?)?.code == 17007 {
                    presentAlert(msg: "이미 가입한 이메일 입니다.")
                } else {
                    presentErrorAlert(error: error)
                }
                hideActivityIndicator()
                return
            }

            completion(result)
        }
    }

    static func changeUser(displayName: String?, completion: @escaping (() -> Void)) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { _ in
            completion()
        }
    }

    static func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let error {
            hideActivityIndicator()
            presentErrorAlert(error: error)
        }
    }
}
