//
//  MySettingViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class MySettingViewController: UITableViewController {
    @IBAction func popAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 3 {
            FirebaseLayer.signOut()
            tabBarController?.selectedIndex = 0
        } else if indexPath.row == 2 {
        }
    }
}
