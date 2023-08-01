//
//  AppDelegate.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/17.
//

import SwiftUI
import Firebase
import FirebaseMessaging


class AppDelegate: NSObject, UIApplicationDelegate {
    @ObservedObject var pokeNotificationManager: PokeNotificationManager = PokeNotificationManager(
            currentUserDeviceToken: UserDefaults.standard.string(forKey: "userDeviceToken")
        )
    
    @ObservedObject var localNotificationManager: LocalNotificationManager = LocalNotificationManager()
    

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        
        /// 원격 알림 등록
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
        
        
        application.registerForRemoteNotifications()
        
        /// 앱이 실행중일 때의 Push Notification 대리자 설정
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}


// MARK: - 알람 처리 메소드 구현
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        /// Foreground Mode: 앱이 포어그라운드에서 실행될 때 도착한 알람 처리
        let userInfo = notification.request.content.userInfo

        completionHandler([.banner, .sound, .badge])
       
    }
    
    
    /// Background Mode: 전달 알림에 대한 사용자 응답을 처리하도록 대리인에 요청
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        
        completionHandler()
    }
}




