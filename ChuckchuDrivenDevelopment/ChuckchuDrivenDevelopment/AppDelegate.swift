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
    @ObservedObject var pushNotificationManager: PushNotificationManager = PushNotificationManager(
            currentUserDeviceToken: UserDefaults.standard.string(forKey: "userDeviceToken")
        )
    

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        /// Push Notification 대리자 설정
        Messaging.messaging().delegate = self
        
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



// MARK: - FCM 메시지 및 토큰 관리
extension AppDelegate: MessagingDelegate {
    /// 메시지 토큰 등록 완료
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(#function, "+++ didRegister Success", deviceToken)
        // Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
    /// 메시지 토큰 등록 실패
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(#function, "DEBUG: +++ register error: \(error.localizedDescription)")
    }
    
    /// 메시지 FCM Device Token 등록 성공
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {
        print(#function, "Messaging")
        let deviceToken: [String: String] = ["token" : fcmToken ?? ""]
        print(#function, "+++ Device Test Token", deviceToken)
        
        /// 현재 fcm 토큰 UserDefaults에 저장
        guard let fcmToken else { return }
        UserDefaults.standard.set(fcmToken, forKey: "userDeviceToken")
        pushNotificationManager.setCurrentUserDeviceToken(token: fcmToken)
    }


    func didReceiveRemoteNotification() {
        // TODO: - 추후 didReceive 메소드를 추가로 구현하여 Push Notification을 탭했을 때의 액션을 추가
    }

}



// MARK: - 알람 처리 메소드 구현
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        /// 앱이 포어그라운드에서 실행될 때 도착한 알람 처리
        let userInfo = notification.request.content.userInfo
        
        print(#function, "+++ willPresent: userInfo: ", userInfo)
        
        completionHandler([.banner, .sound, .badge])
    }
    
    /// 전달 알림에 대한 사용자 응답을 처리하도록 대리인에 요청
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(#function, "+++ didReceive: userInfo: ", userInfo)
        completionHandler()
    }
}



