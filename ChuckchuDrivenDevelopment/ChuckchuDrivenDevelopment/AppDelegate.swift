//
//  AppDelegate.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/17.
//

import SwiftUI
import BackgroundTasks

class AppDelegate: UIResponder, UIApplicationDelegate {
    @ObservedObject var localNotificationManager: LocalNotificationManager = LocalNotificationManager()
   
    let calendar = Calendar.current
    
    var weekdays: [Int] = UserDefaults.standard.array(forKey: "notificationWeekdays") as? [Int] ?? []
    var startHour: Int = UserDefaults.standard.integer(forKey: "notificationStartHour")
    var endHour: Int = UserDefaults.standard.integer(forKey: "notificationEndHour")
    var frequency: Int = UserDefaults.standard.integer(forKey: "notificationFrequency")

    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        /// background fetch 관련 작업을 등록
        /// 앱이 꺼지면 task scheduler를 등록하고 refresh를 스케줄한다
        BGTaskScheduler.shared.register(forTaskWithIdentifier: UUID().uuidString,
                                        using: nil) { task in
            task.setTaskCompleted(success: true)
            /// 요일이 바뀌면, 현재 요일과 userDefaults에 저장된 요일 데이터 비교
            /// 현재 요일이 데이터에 포함될 시 새로운 알림 리스트 생성
            let currentWeekday = getCurrentWeekday()
            
            for weekday in self.weekdays {
                if weekday == currentWeekday {
                    self.localNotificationManager.setLocalNotification(
                        weekday: weekday,
                        startHour: self.startHour,
                        endHour: self.endHour,
                        frequency: MinuteInterval(rawValue: self.frequency) ?? .hour)
                   
                    self.scheduleAppRefresh() // 다음 background refresh 예약
                }
            }
        }
        scheduleAppRefresh() // FIXME: 이게 왜 한 번 더 들어가야 하는 거지?
        
        /// 시스템 알림 허용이 됐는지 구분
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



// MARK: - Background fetch 핸들링 관련
extension AppDelegate {
    /// BGAppRefreshTaskRequest 생성 후 BGTaskScheduler.submit(_:)을 통해 request 발송
    func scheduleAppRefresh() {
        /// 현재 요일을 파악하기 위해, 매일 자정에 background refresh가 요청 됨
        let dateComponents = DateComponents(hour: 0, minute: 0, second: 0)
        let refreshDate = calendar.date(from: dateComponents)
        let request = BGAppRefreshTaskRequest(identifier: UUID().uuidString)
        request.earliestBeginDate = refreshDate
        do {
            try BGTaskScheduler.shared.submit(request)
            print("background refresh scheduled")
        } catch {
            print("Couldn't schedule app refresh \(error.localizedDescription)")
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

