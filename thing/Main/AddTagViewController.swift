//
//  AddTagViewController.swift
//  thing
//
//  Created by Jinha Park on 2019/08/06.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

final class AddTagViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        requestTags()
    }

    @IBAction private func completeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddTagViewController {
    private func requestTags() {
        ThingProvider.tags(completion: { tags in
            Log(tags)
        }) { error in
            Log(error)
        }
    }
}
