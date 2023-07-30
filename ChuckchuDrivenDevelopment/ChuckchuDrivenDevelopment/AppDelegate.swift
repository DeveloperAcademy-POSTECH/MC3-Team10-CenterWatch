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
        
        // MARK: - 시스템 알림 허용 여부 구분
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
      
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.liannechoi.ChuckchuDrivenDevelopment.task.refresh",
            using: nil
        ) { task in
            self.handleAppRefresh(task: task as! BGProcessingTask)
        }
        return true
    }
}


extension AppDelegate {
  
    func scheduleAppRefresh() {
        /// 현재 요일을 파악하기 위해, 매일 자정에 background refresh가 요청 됨
        let request = BGProcessingTaskRequest(identifier: "com.liannechoi.ChuckchuDrivenDevelopment.task.refresh")
        let dateComponents = DateComponents(hour: 0, minute: 0, second: 0)
        let refreshDate = calendar.date(from: dateComponents)
        request.earliestBeginDate = refreshDate
        request.requiresNetworkConnectivity = false
        request.requiresExternalPower = false

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    

    func handleAppRefresh(task: BGProcessingTask) {
        scheduleAppRefresh()
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        let currentWeekday = getCurrentWeekday()
        
        for weekday in self.weekdays {
            if weekday == currentWeekday {
                self.localNotificationManager.setLocalNotification(
                    weekday: weekday,
                    startHour: self.startHour,
                    endHour: self.endHour,
                    frequency: TimeInterval(rawValue: self.frequency) ?? .hour)
               
                // self.scheduleAppRefresh() // 다음 background refresh 예약
                print("successfully gone through the task >>> ", weekday)
            }
        }
        task.setTaskCompleted(success: true)
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


