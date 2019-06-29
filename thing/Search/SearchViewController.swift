//
//  SearchViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var searchWord: [String]?

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cancelButtonWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var navigationBarHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        fetch()
    }

    private func fetch() {

    }

    private func endEditing() {
        view.endEditing(true)

        cancelButtonWidthConstraint.constant = 0
        navigationBarHeightConstraint.constant = 99

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

    @IBAction func cancelTouchAction(_ sender: Any) {
        endEditing()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchWordTableViewCell", for: indexPath) as! SearchWordTableViewCell

        cell.titleLabel.text = "하이"

        return cell
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        cancelButtonWidthConstraint.constant = 43
        navigationBarHeightConstraint.constant = 44

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

        return true
    }

    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        endEditing()
        return false
    }
}
