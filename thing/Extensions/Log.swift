//
//  Log.swift
//  thing
//
//  Created by 이재성 on 2019/06/14.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

func presentErrorAlert(error: Error?) {
    Log(error?.localizedDescription)
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
