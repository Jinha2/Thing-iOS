//
//  FirebaseLayer.swift
//  thing
//
//  Created by 이재성 on 2019/06/16.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import FirebaseAuth

struct FirebaseLayer {
    static func isUserSignedIn() -> Bool {
        guard Auth.auth().currentUser != nil else { return false }
        return true
    }

    static func getUid() {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { result, error in
            if error != nil {
                Log(error?.localizedDescription)
                return
            }

            Log(result)
        })
    }

    static func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                Log(error?.localizedDescription)
                return
            }

            Log(result)
        }
    }

    static func changeUser(displayName: String?) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { error in
            Log(error?.localizedDescription)
        }
    }

    static func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
