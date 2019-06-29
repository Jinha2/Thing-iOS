//
//  SearchViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/06/29.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
