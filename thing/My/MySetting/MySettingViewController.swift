//
//  MySettingViewController.swift
//  thing
//
//  Created by 이재성 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class MySettingViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //문의메일
                let mailComposeViewController = configuredMailComposeViewController()
                if MFMailComposeViewController.canSendMail() {
                    present(mailComposeViewController, animated: true, completion: nil)
                } else {
                    showSendMailErrorAlert()
                }
            }
            if indexPath.row == 1 {
                //별점 남기기
                SKStoreReviewController.requestReview()
            }
            if indexPath.row == 2 {

            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                FirebaseLayer.signOut()
                tabBarController?.selectedIndex = 0
            }
        }
    }
}

extension MySettingViewController: MFMailComposeViewControllerDelegate {
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["kaskay77@gmail.com"])
        mailComposerVC.setSubject("U2U 문의 메일")
        mailComposerVC.setMessageBody("여러분의 소중한 의견 감사드립니다.", isHTML: false)

        return mailComposerVC
    }

    func showSendMailErrorAlert() {
        let alertController = UIAlertController(title: "에러", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let action = UIAlertAction(title: "네", style: .default) { _ in }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
