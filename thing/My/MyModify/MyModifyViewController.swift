//
//  MyModifyViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class MyModifyViewController: UIViewController {
    @IBOutlet weak var imageButton: UIButton!
    let picker = UIImagePickerController()
    @IBAction func popAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func imageChangeAction(_ sender: Any) {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
    }
}

extension MyModifyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageButton.setImage(image, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}
