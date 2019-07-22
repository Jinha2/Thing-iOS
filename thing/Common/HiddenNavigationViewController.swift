//
//  HiddenNavigationViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class HiddenNavigationViewController: UINavigationController {
    private var popRecognizer: InteractivePopRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopRecognizer()
    }

    private func setupPopRecognizer() {
        popRecognizer = InteractivePopRecognizer(controller: self)
    }
}

class InteractivePopRecognizer: NSObject {
    fileprivate weak var navigationController: UINavigationController?

    init(controller: UINavigationController) {
        self.navigationController = controller

        super.init()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension InteractivePopRecognizer: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
