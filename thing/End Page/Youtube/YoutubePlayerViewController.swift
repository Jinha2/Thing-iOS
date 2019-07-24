//
//  YoutubePlayerViewController.swift
//  thing
//
//  Created by 이호찬 on 2019/07/25.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class YoutubePlayerViewController: UIViewController {

    var youtubePlayerView: YoutubePlayerView? {
        didSet {
            youtubePlayerView?.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("나가기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        youtubePlayerView?.delegate = self
        setLayout()
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
}

extension YoutubePlayerViewController {
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}

extension YoutubePlayerViewController {
    private func setLayout() {
        view.addSubview(youtubePlayerView ?? UIView())
        view.addSubview(button)

        youtubePlayerView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        youtubePlayerView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        youtubePlayerView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        youtubePlayerView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
}

extension YoutubePlayerViewController {
    static func newViewController(id: String) -> YoutubePlayerViewController {
        let vc = YoutubePlayerViewController()
        vc.youtubePlayerView = YoutubePlayerView(id: id)
        return vc
    }
}

extension YoutubePlayerViewController: YoutubePlayerViewDelegate {
    func playerReady(_ player: YoutubePlayerView) {

    }
}
