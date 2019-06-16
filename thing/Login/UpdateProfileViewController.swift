//
//  UpdateProfileViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/16.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        ageTextField.delegate = self
    }

    @IBAction private func completeButtonAction(_ sender: Any) {
        guard let displayName = displayNameTextField.text, let age = ageTextField.text, checkValidation() else { return }
        
        FirebaseLayer.changeUser(displayName: displayName)

        // 우리서버에 날려야함
        showActivityIndicator()
        hideActivityIndicator()
    }
}

extension UpdateProfileViewController {
    func checkValidation() -> Bool {
        guard let displayName = displayNameTextField.text, let age = ageTextField.text else { return false }

        return isValidDisplayName(displayName: displayName) && isValidAge(age: age)
    }

    func isValidDisplayName(displayName: String) -> Bool {
        if !displayName.isEmpty {
            return true
        }

        presentAlert(msg: "닉네임은 필수 입력입니다")
        return false
    }

    func isValidAge(age: String) -> Bool {
        if age.count == 4 || age.count == 0 {
            return true
        }

        presentAlert(msg: "생년을 4자리로 입력해주세요")
        return false
    }
}

extension UpdateProfileViewController: UITextFieldDelegate {
    func checkOnlyNumber(string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined()

        return string == numberFiltered
    }

    func checkMaxLength(maxLength: Int, textField: UITextField, range: NSRange, string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count

        return count <= maxLength
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return checkOnlyNumber(string: string) && checkMaxLength(maxLength: 4, textField: textField, range: range, string: string)
    }
}
