//
//  AppDelegate.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/17.
//

import SwiftUI
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    @ObservedObject var localNotificationManager: LocalNotificationManager = LocalNotificationManager()
   
    let calendar = Calendar.current
    
    var weekdays: [Int] = UserDefaults.standard.array(forKey: "notificationWeekdays") as? [Int] ?? []
    var startHour: Int = UserDefaults.standard.integer(forKey: "notificationStartHour")
    var endHour: Int = UserDefaults.standard.integer(forKey: "notificationEndHour")
    var frequency: Int = UserDefaults.standard.integer(forKey: "notificationFrequency")


    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        switchAuthorizationStatus()
        UNUserNotificationCenter.current().delegate = self

        return true
    }
}



// MARK: - 알림 액션 핸들링 관련
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



// MARK: - Switch Authorization Status (Method)
/// 시스템 알림 허용 여부를 파악하고 케이스에 맞게 뷰를 처리합니다.
private func switchAuthorizationStatus() {
    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
     
        switch settings.authorizationStatus {
    
        case .notDetermined:
            print("Authorization not determined.")
            
        case .denied:
            UserDefaults.standard.set(false, forKey: "isNotiAuthorized")
            print("Authorization denied. You can't switch it on programmatically.")
       
        case .authorized:
            UserDefaults.standard.set(true, forKey: "isNotiAuthorized")
            print("Authorization already granted.")
       
        case .provisional:
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if granted {
                    print("Switched to authorized.")
                } else {
                    print("Authorization still denied.")
                }
            }
        case .ephemeral:
            print("Authorization is ephemeral. You can't switch it on programmatically.")
        @unknown default:
            print("Unknown authorization status.")
        }
    }
}
