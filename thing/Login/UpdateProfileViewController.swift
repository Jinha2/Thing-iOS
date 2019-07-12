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
    @IBOutlet var manButtonAction: UIButton!
    @IBOutlet var womanButtonAction: UIButton!
    @IBOutlet var noneButtonAction: UIButton!

    var year = [Int]()
    var 성별: Int?
    var 현재버튼: UIButton?
    var selectedYear: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        let pickerView = UIPickerView()

        hideKeyboardWhenTappedAround()
        ageTextField.delegate = self
        pickerView.delegate = self
        ageTextField.inputView = pickerView

        for y in 1930...2019 {
            year.append(y)
        }
    }
    @IBAction func manButtonAction(_ sender: UIButton) {
        성별선택(sender: sender, type: 1)
        manButtonAction.isSelected = manButtonAction.isSelected ? false : true
    }
    @IBAction func womanButtonAction(_ sender: UIButton) {
        성별선택(sender: sender, type: 0)
        womanButtonAction.isSelected = womanButtonAction.isSelected ? false : true
    }
    @IBAction func noneButtonAction(_ sender: UIButton) {
        성별선택(sender: sender, type: 2)
        noneButtonAction.isSelected = noneButtonAction.isSelected ? false : true
    }

    func 성별선택(sender: UIButton, type: Int) {
        sender.isSelected = true
        현재버튼?.isSelected = false
        현재버튼 = sender
        성별 = type
    }

    @IBAction private func completeButtonAction(_ sender: Any) {
        guard let uid = FirebaseLayer.getUid(), let displayName = displayNameTextField.text, checkValidation() else { return }
        ThingProvider().signUp(uid: uid, nickname: displayName, gender: 성별, birth: selectedYear, completion: { data in
            Log(data)
            FirebaseLayer.changeUser(displayName: displayName) { [weak self] in
                hideActivityIndicator()
                self?.dismiss(animated: true, completion: nil)
            }
        }) { error in
            presentErrorAlert(error: error)
        }
        showActivityIndicator()
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension UpdateProfileViewController {
    func checkValidation() -> Bool {
        guard let displayName = displayNameTextField.text, let age = ageTextField.text else { return false }

        return isValidDisplayName(displayName: displayName)
    }

    func isValidDisplayName(displayName: String) -> Bool {
        if !displayName.isEmpty {
            return true
        }

        presentAlert(msg: "닉네임은 필수 입력입니다")
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
}

extension UpdateProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(year[year.count - row - 1])"
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return year.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cal = Calendar.current
        let date = Date()
        let currentYear = cal.component(.year, from: date)
        selectedYear = year[year.count - row - 1]
        ageTextField.text = "\(year[year.count - row - 1]), 만 \(currentYear - year[year.count - row - 1])세"
    }

}
