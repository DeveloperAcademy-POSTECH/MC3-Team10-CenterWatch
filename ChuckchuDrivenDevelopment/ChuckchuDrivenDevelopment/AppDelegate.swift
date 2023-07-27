//
//  AppDelegate.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/17.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    @ObservedObject var localNotificationManager: LocalNotificationManager = LocalNotificationManager()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
        if localNotificationManager.isAuthorizationRequested {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate

                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

                UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: { _, _ in }
                )

            } else {
                let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
            }
        }
        
        application.registerForRemoteNotifications()

        UNUserNotificationCenter.current().delegate = self
       
        return true
    }
}


// MARK: - 알람 처리
extension AppDelegate: UNUserNotificationCenterDelegate {

    /// in Foreground
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }

    /// in Background
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        switch response.actionIdentifier {
        case "resetNotificationTimeAction":
            return
        default:
            break
        }
        completionHandler()
    }
}



