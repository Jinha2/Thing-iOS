//
//  Common.swift
//  thing
//
//  Created by 이재성 on 2019/06/14.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

func presentAlert(msg: String) {
    let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))

    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController()
    alertWindow.windowLevel = UIWindow.Level.alert + 1
    alertWindow.makeKeyAndVisible()
    alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
}

func presentErrorAlert(error: Error?) {
    Log(error?.localizedDescription)
    hideActivityIndicator()

    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))

    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController()
    alertWindow.windowLevel = UIWindow.Level.alert + 1
    alertWindow.makeKeyAndVisible()
    alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
}

func Log<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
    let value = object()
    let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
    let queue = Thread.isMainThread ? "UI" : "BG"

    print("❤️ <\(queue)> \(fileURL) \(function)[\(line)]: " + String(reflecting: value))
    #endif
}

var activityIndicator: NVActivityIndicatorView?

extension UIViewController {
    func showActivityIndicator() {
        let width: CGFloat = 40
        let height: CGFloat = 40
        let x: CGFloat = (UIScreen.main.bounds.maxX - width) / 2
        let y: CGFloat = (UIScreen.main.bounds.maxY - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.allCases.randomElement(), color: .black, padding: 0)
        activityIndicator = activityIndicatorView
        view.addSubview(activityIndicatorView)

        activityIndicatorView.startAnimating()
    }
}

func hideActivityIndicator() {
    activityIndicator?.stopAnimating()
}
