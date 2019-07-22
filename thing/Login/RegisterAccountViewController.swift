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
    @IBOutlet var checkButtonAction: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        clickLink()
        hideKeyboardWhenTappedAround()
    }

    @IBAction private func nextButtonAction(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, checkValidation(), checkButtonAction.isSelected else { return }

        showActivityIndicator()
        FirebaseLayer.createUser(email: email, password: password, completion: { [weak self] _ in
            hideActivityIndicator()
            guard let updateProfileViewController = self?.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileViewController") else { return }
            self?.navigationController?.pushViewController(updateProfileViewController, animated: true)
        })
    }

    @IBAction private func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func checkButtonAction(_ sender: Any) {
        checkButtonAction.isSelected = checkButtonAction.isSelected ? false : true

    }
}

extension RegisterAccountViewController {
    private func checkValidation() -> Bool {
        if checkButtonAction.isSelected == false {
            let alert = UIAlertController(title: "ERROR", message: "개인정보 보호 정책에 동의해주셔야 가입이 가능합니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }

        guard let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmTextField.text else { return false }

        return isValidEmail(enteredEmail: email) && isValidPassword(password: password) && isEqaul(password: password, confirm: confirm)
    }

    private func isValidPassword(password: String) -> Bool {
        if password.count >= 6 {
            return true
        }
        presentAlert(msg: "비밀번호는 최소 6자리 이상이어야 합니다")
        return false
    }

    private func isValidEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)

        if emailPredicate.evaluate(with: enteredEmail) {
            return true
        }

        presentAlert(msg: "이메일 양식이 올바르지 않습니다")
        return false
    }

    private func isEqaul(password: String, confirm: String) -> Bool {
        if password == confirm {
            return true
        }
        presentAlert(msg: "비밀번호가 일치하지 않습니다")
        return false
    }

    private func clickLink() {
        let attributedString = NSMutableAttributedString(string: "회원가입에 따른 개인정보 보호 정책에 동의(필수)")
        guard let url = URL(string: "https://github.com/JeaSungLEE/Privacy-Policy/blob/master/U2U2.md"), let color = UIColor(named: "brownGreyThree") else { return }

        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: UIFont.boldSystemFont(ofSize: 13), range: NSRange(location: 9, length: 10))

        attributedString.setAttributes([.link: url], range: NSRange(location: 9, length: 10))

        agreeLinkTextView.attributedText = attributedString
        agreeLinkTextView.isUserInteractionEnabled = true
        agreeLinkTextView.isEditable = false

        agreeLinkTextView.linkTextAttributes = [
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
}
