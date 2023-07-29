//
//  LocalNotificationManager.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/21.
//

import SwiftUI
import UserNotifications


class LocalNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var isAuthorizationRequested: Bool = false
     
    private let notificationCenter = UNUserNotificationCenter.current()
    private let notificationContent = UNMutableNotificationContent()
    private let calendar = Calendar.current
    private let notificationTitle = NotificationTitle().variations

    var text: NSMutableAttributedString? = NSMutableAttributedString(string: "List of notification requests and it's time\n")
    
    
    
    
    // MARK: - Request Notification Permission (Method)
    /// 
    public func requestNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
           if let error {
                print(error)
            }
        }
    }
        
    
    // MARK: - Set Local Notification (Method)
    /// 맞춤 설정된 스케줄을 토대로 로컬 알림을 발송합니다.
    public func setLocalNotification(
        weekday: Int,
        startHour: Int,
        endHour: Int,
        frequency: MinuteInterval
    ) {
        requestWeekdayTrigger(weekday: weekday, startHour: startHour, endHour: endHour, frequency: frequency)
    }
    
    
    // MARK: - Request Weekday Trigger (Method)
    /// 요일별 푸시 알림 예약을 생성하고 알림을 요청합니다.
    /// parameter: 알림 요일 설정 값 (weekday)  |  시작 시간 값 (startHour)  |  종료 시간 값 (endHour)  |  알림 빈도 설정 값 (frequency)
    private func requestWeekdayTrigger(
        weekday: Int,
        startHour: Int,
        endHour: Int,
        frequency: MinuteInterval
    ) {
        requestNotificationPermission()
        initNotificationCenter()
        
        /// 0시 -> 24시로 계산되게 하기
        var endHour = endHour
        if endHour == 0 {
            endHour = 24
        }
        
        /* 빈도 설정으로 들어온 횟수만큼 알림 요청 생성 */
        switch frequency {
        case .hour:
            /// startHour에서 증가하는 인터벌 알림 예약 생성 및 요청
            for count in 1...(endHour - startHour) + 1 { // 알림의 반복 횟수
                
                makeNotificationContent(with: notificationTitle)
                
                let hour = startHour + (count - 1)
                let minute = 0
                
                var dateInfo = DateComponents()
                dateInfo.hour = hour
                dateInfo.minute = minute
                dateInfo.second = 0
                dateInfo.weekday = weekday
                dateInfo.timeZone = .current
                dateInfo.calendar = calendar
                
                let identifier = UUID().uuidString + "\(count)" + "\(weekday)"
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)
                
                self.notificationCenter.add(request)
            }
            
            
        case .halfHour:
            for count in 1...(endHour - startHour) * 2 + 1 {
                
                makeNotificationContent(with: notificationTitle)
                
                // 다 분으로 계산하고 마지막에 시로 바꿔줌
                let totalMinute = 30 * (count - 1)
                var hour = startHour
                var minute = 0
                
                if totalMinute >= 60 {
                    hour = startHour + (Int(totalMinute / 60))
                }
                
                if count % 2 == 0 {
                    minute = 30
                }
                
                /*
                 120min example:
                 
                 9   930   10    1030    11
                 0.   1.    2.     3.     4
                 0    30    60.    90    120
                 */
                
                var dateInfo = DateComponents()
                dateInfo.hour = hour
                dateInfo.minute = minute
                dateInfo.second = 0
                dateInfo.weekday = weekday
                dateInfo.timeZone = .current
                dateInfo.calendar = calendar
                
                let identifier = UUID().uuidString + "\(count)" + "\(weekday)"
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
                
                notificationCenter.getPendingNotificationRequests { requests in
                    for request in requests {
                        print(">>> notification: ", request)
                    }
                }
                
                
            }
        }
        
        
        
        
        
        notificationCenter.getPendingNotificationRequests { messages in
            print("Notification Schdule Complete: ", messages)
        }
    }
    
    
    
    
    // MARK: - Cancel Notification (Method)
    /// 예약이 된 모든 알림 요청을 삭제합니다.
    public func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
    
    
    
    /* 리팩토링에 쓰일 함수 리스트 */
    
    // MARK: - NotificationCenter Init (Method)
    private func initNotificationCenter() {
        notificationCenter.delegate = self
    }
    
    // MARK: - Notification Content (Method)
    private func makeNotificationContent(with titles: [String]) {
        notificationContent.title = titles.randomElement() ?? "허리피라우🐢"
        notificationContent.body = "자세를 바로잡아주세요!"
        notificationContent.categoryIdentifier = "alarm"
        notificationContent.userInfo = ["허리피라우": "허우"]
        notificationContent.sound = UNNotificationSound.default
    }
      
}





extension LocalNotificationManager {
    
    func handleNotificationAction() {
        /// Define the custom actions.
        let resetTimeAction = UNNotificationAction(identifier: "resetNotificationTimeAction",
              title: "알림 시간 재설정 하러 가기",
              options: [])
        /// Define the notification type
        let resetTimeActionCategory =
              UNNotificationCategory(identifier: "resetTimeActionCategory",
              actions: [resetTimeAction],
              intentIdentifiers: [],
              hiddenPreviewsBodyPlaceholder: "알림이 너무 자주 오나요?",
              options: .customDismissAction)
        /// Register the notification type.
        notificationCenter.setNotificationCategories([resetTimeActionCategory])
    }
}


