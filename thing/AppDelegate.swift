//
//  AppDelegate.swift
//  thing
//
//  Created by 이호찬 on 10/06/2019.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setTabbarCustom()
        
        //GA를 위해서 사용
        FirebaseApp.configure()
        //Firebase Push
        setPushToken(application)
        //Google Login
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            Log("Message ID: \(messageID)")
        }

        Log(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            Log("Message ID: \(messageID)")
        }

        Log(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate {
    func setPushToken(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in })

        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self
    }

    func setTabbarCustom() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            Log("Message ID: \(messageID)")
        }

        Log(userInfo)

        completionHandler([])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            Log("Message ID: \(messageID)")
        }

        Log(userInfo)

        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        Log("Firebase registration token: \(fcmToken)")

        let dataDict: [String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        FirebaseLayer.sign(signIn, user, error) { result in
            Log(result)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
}
