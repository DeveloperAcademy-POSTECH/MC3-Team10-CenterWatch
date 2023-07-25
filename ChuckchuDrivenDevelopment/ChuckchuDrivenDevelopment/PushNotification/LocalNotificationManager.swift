//
//  LocalNotificationManager.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/21.
//

import SwiftUI
import UserNotifications


class LocalNotificationManager: ObservableObject {
    
    static let instance = LocalNotificationManager()
    //    private init() {}
    
    var badgeCount: NSNumber?
    
    // MARK: - requestWeekdayTrigger (Method)
    /// 요일별 푸시 알림 예약을 생성하고 알림을 요청합니다.
    /// parameter: 알림 요일 설정 값 (weekday)  |  시작 시간 값 (startHour)  |  종료 시간 값 (endHour)  |  알림 빈도 설정 값 (frequency)
    func requestCalendarTrigger(weekday: Int,
                                startHour: Int,
                                endHour: Int,
                                frequency: MinuteInterval) {
        
        /// 푸시 알림의 내용 정의
        let content = UNMutableNotificationContent()
        let notificationTitle = NotificationTitle()
        content.title = notificationTitle.variations.randomElement() ?? "휴식도 좋은 개발의 일부에요."
        content.subtitle = "허리를 펼 시간이에요. 자세를 바로잡아주세요!"
        content.sound = .default
        content.badge = badgeCount


        /* 빈도 설정으로 들어온 횟수만큼 알림 요청 생성 */
        switch frequency {
        case .hour:
            /// startHour에서 증가하는 인터벌 알림 예약 생성 및 요청
            for _ in 1...(endHour - startHour) + 1 { // 알림의 반복 횟수
                /// DateComponents -> Date
                let dateComponents = DateComponents(hour: startHour-1, minute: 0, weekday: weekday)
                let date = Calendar.current.date(from: dateComponents)
                /// Date += hour
                let nextTriggerDate = Calendar.current.date(byAdding: .hour, value: 1, to: date ?? Date())
                /// Date -> DateComponents
                let nextTriggerDateComopnents = Calendar.current.dateComponents([.weekday, .hour, .minute], from: nextTriggerDate ?? Date())

                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: nextTriggerDateComopnents, repeats: true)
                let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: notificationTrigger)
              
                UNUserNotificationCenter.current().add(notificationRequest)
                
                self.badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
            }
            
        case .halfHour:
            for _ in 1...(endHour - startHour) * 2 + 1 {
                /// DateComponents -> Date
                let dateComponents = DateComponents(hour: startHour-1, minute: 30, weekday: weekday)
                let date = Calendar.current.date(from: dateComponents)
                /// Date += hour
                let nextTriggerDate = Calendar.current.date(byAdding: .minute, value: 30, to: date ?? Date())
                /// Date -> DateComponents
                let nextTriggerDateComopnents = Calendar.current.dateComponents([.weekday, .hour, .minute], from: nextTriggerDate ?? Date())

                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: nextTriggerDateComopnents, repeats: true)
                let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: notificationTrigger)
                
                UNUserNotificationCenter.current().add(notificationRequest)
                
                self.badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
            }
            
        case .quarterHour:
            for _ in 1...(endHour - startHour) * 4 + 1 {
                /// DateComponents -> Date
                let dateComponents = DateComponents(hour: startHour-1, minute: 45, weekday: weekday)
                let date = Calendar.current.date(from: dateComponents)
                /// Date += hour
                let nextTriggerDate = Calendar.current.date(byAdding: .minute, value: 15, to: date ?? Date())
                /// Date -> DateComponents
                let nextTriggerDateComopnents = Calendar.current.dateComponents([.weekday, .hour, .minute], from: nextTriggerDate ?? Date())

                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: nextTriggerDateComopnents, repeats: true)
                let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: notificationTrigger)
               
                UNUserNotificationCenter.current().add(notificationRequest)
                
                self.badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
            }
    
        case .tenMinutes:
            for _ in 1...(endHour - startHour) * 5 + 1 {
                /// DateComponents -> Date
                let dateComponents = DateComponents(hour: startHour-1, minute: 50, weekday: weekday)
                let date = Calendar.current.date(from: dateComponents)
                /// Date += hour
                let nextTriggerDate = Calendar.current.date(byAdding: .minute, value: 10, to: date ?? Date())
                /// Date -> DateComponents
                let nextTriggerDateComopnents = Calendar.current.dateComponents([.weekday, .hour, .minute], from: nextTriggerDate ?? Date())

                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: nextTriggerDateComopnents, repeats: true)
                let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: notificationTrigger)
                
                UNUserNotificationCenter.current().add(notificationRequest)
                
                self.badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
            }
        }
    
        print("-----------Manager----------")
        print("요일 알림 요청이 발송되었습니다🎉")
        print("startHour: ", startHour, "| endHour: ", endHour, "weeday: ", weekday)
    }
    
    
    
    // MARK: - setLocalNotification (Method)
    /// 맞춤 설정된 스케줄을 토대로 로컬 알림을 발송합니다.
    func setLocalNotification(weekdays: [Int], startHour: Int, endHour: Int, frequency: MinuteInterval) {
        let manager = LocalNotificationManager.instance
        
        for weekday in weekdays {
            manager.requestCalendarTrigger(weekday: weekday, startHour: startHour, endHour: endHour, frequency: frequency)
        }
    }
    
    
    
    // MARK: - cancelNotification (Method)
    /// 예약이 된 모든 알림 요청을 삭제합니다.
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}

