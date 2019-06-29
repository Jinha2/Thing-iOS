//
//  RegisterAccountViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/14.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class RegisterAccountViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet var agreeLinkTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }

    @IBAction private func nextButtonAction(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, checkValidation() else { return }

        showActivityIndicator()

        FirebaseLayer.createUser(email: email, password: password, completion: { [weak self] result in
            hideActivityIndicator()
            guard let updateProfileViewController = self?.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileViewController") else { return }
            self?.navigationController?.pushViewController(updateProfileViewController, animated: true)
            Log(result)
        })
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension RegisterAccountViewController {
    func checkValidation() -> Bool {
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmTextField.text else { return false }

        return isValidEmail(enteredEmail: email) && isValidPassword(password: password) && isEqaul(password: password, confirm: confirm)
    }

    func isValidPassword(password: String) -> Bool {
        if password.count >= 6 {
            return true
        }
        presentAlert(msg: "비밀번호는 최소 6자리 이상이어야 합니다")
        return false
    }

    func isValidEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)

        if emailPredicate.evaluate(with: enteredEmail) {
            return true
        }

        presentAlert(msg: "이메일 양식이 올바르지 않습니다")
        return false
    }

    func isEqaul(password: String, confirm: String) -> Bool {
        if password == confirm {
            return true
        }
        presentAlert(msg: "비밀번호가 일치하지 않습니다")
        return false
    }

    func clickLink() {
        let attributedString = NSMutableAttributedString(string: "회원가입에 따른 이용약관과 개인정보 보호 정책에 동의(필수)")
        let url = URL(string: "https://www.apple.com")!

        attributedString.setAttributes([.link: url], range: NSRange(location: 8, length: 4))

        self.agreeLinkTextView.attributedText = attributedString
        self.agreeLinkTextView.isUserInteractionEnabled = true
        self.agreeLinkTextView.isEditable = false

        self.agreeLinkTextView.linkTextAttributes = [
            .foregroundColor: UIColor.lightGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
}
