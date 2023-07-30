//
//  AppDelegate.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/17.
//

import Firebase
import FirebaseMessaging
import SwiftUI


class AppDelegate: UIResponder, UIApplicationDelegate {
   
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    @ObservedObject var silentNotificationManager: SilentPushNotificationManager = SilentPushNotificationManager(
        currentUserDeviceToken: UserDefaults.standard.string(forKey: "userDeviceToken")
    )
    
    let userDeviceToken = UserDefaults.standard.string(forKey: "userDeviceToken")
    let calendar = Calendar.current
    
    var weekdays: [Int] = UserDefaults.standard.array(forKey: "notificationWeekdays") as? [Int] ?? []
    var startHour: Int = UserDefaults.standard.integer(forKey: "notificationStartHour")
    var endHour: Int = UserDefaults.standard.integer(forKey: "notificationEndHour")
    var frequency: Int = UserDefaults.standard.integer(forKey: "notificationFrequency")



    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        /// Push Notification 대리자 설정
        Messaging.messaging().delegate = self
        
        
        // MARK: - 시스템 알림 허용 여부 구분
        if localNotificationManager.isAuthorizationRequested {
           
            if #available(iOS 10.0, *) {
                /// 원격 알림 등록
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
        
        /// 앱이 실행중일 때의 Push Notification 대리자 설정
        UNUserNotificationCenter.current().delegate = self
      

        return true
    }
}
 


// MARK: - FCM 토큰 관련
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
        silentNotificationManager.setCurrentUserDeviceToken(token: fcmToken)
    }

}


// MARK: - FCM Silent Push Notification 수신 처리 관련
extension AppDelegate {
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        /// 새로운 요일의 알림 생성
        setNextLocalNotification()
        
        /// 확인 코드
        UNUserNotificationCenter.current().getPendingNotificationRequests { messages in
            print(">>>> [in AppDelegate] Notification Schdule Complete: ", messages)
        }
        
        /// 다음날의 Silent Push Notification 예약
        if let userDeviceToken {
            silentNotificationManager.setCurrentUserDeviceToken(token: userDeviceToken)
        }
    }
    

    func setNextLocalNotification() {
        let currentWeekday = getCurrentWeekday()
        /// 현재 요일이 예약된 요일 리스트에 포함된다면 새로운 알림 요청 리스트 생성
        for weekday in self.weekdays {
            if weekday == currentWeekday {
                self.localNotificationManager.setLocalNotification(
                    weekday: weekday,
                    startHour: self.startHour,
                    endHour: self.endHour,
                    frequency: TimeInterval(rawValue: self.frequency) ?? .hour)
               
                print("successfully gone through the task >>> ", weekday)
            }
        }
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


