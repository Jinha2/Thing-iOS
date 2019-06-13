//
//  RegisterAccountViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/14.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class RegisterAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RegisterAccountViewController {
    private func isValidEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    private func isEqaul(password: String, confirm: String) -> Bool {
        return password == confirm
    }
}
