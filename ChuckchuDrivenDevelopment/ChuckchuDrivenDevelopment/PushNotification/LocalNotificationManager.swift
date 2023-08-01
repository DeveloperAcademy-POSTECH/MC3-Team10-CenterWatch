//
//  LocalNotificationManager.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/21.
//

import SwiftUI
import UserNotifications


class LocalNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    private let notificationContent = UNMutableNotificationContent()
    private let calendar = Calendar.current
    private let notificationTitle = NotificationTitle().variations.randomElement() ?? "허리피라우🐢"
    var badgeCount: NSNumber?
    
    
    // MARK: - setLocalNotification (Method)
    /// 맞춤 설정된 스케줄을 토대로 로컬 알림을 발송합니다.
    public func setLocalNotification(
        weekdays: [Int],
        startHour: Int,
        endHour: Int,
        frequency: MinuteInterval
    ) {
        
        requestWeekdayTrigger(weekdays: weekdays, startHour: startHour, endHour: endHour, frequency: frequency)
    }
    
    
    // MARK: - requestWeekdayTrigger (Method)
    /// 요일별 푸시 알림 예약을 생성하고 알림을 요청합니다.
    /// parameter: 알림 요일 설정 값 (weekday)  |  시작 시간 값 (startHour)  |  종료 시간 값 (endHour)  |  알림 빈도 설정 값 (frequency)
    private func requestWeekdayTrigger(
        weekdays: [Int],
        startHour: Int,
        endHour: Int,
        frequency: MinuteInterval
    ) {
        initNotificationCenter()
        makeNotificationContent(with: notificationTitle)
        
        
        /*testing codes:
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
         
         let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
         notificationCenter.add(request)
         */
        
        
        for weekday in weekdays {
            /* 빈도 설정으로 들어온 횟수만큼 알림 요청 생성 */
            switch frequency {
            case .hour:
                /// startHour에서 증가하는 인터벌 알림 예약 생성 및 요청
                for i in 1...(endHour - startHour) + 1 { // 알림의 반복 횟수
                    
                    let count = i - 1
                    let hour = startHour + count
                    let minute = 0
                    
                    var dateInfo = DateComponents()
                    dateInfo.hour = hour
                    dateInfo.minute = minute
                    dateInfo.weekday = weekday
                    dateInfo.timeZone = .current
                    
                    print(">>>> hour: ", hour)
                    print(">>>> minute: ", minute)
                    print(">>>> weekday: ", weekday)
                    
                    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                    let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: notificationTrigger)
                    
                    self.notificationCenter.add(notificationRequest)
                    
                    notificationCenter.getPendingNotificationRequests { requests in
                        print(">>> Request Appended", requests)
                    }
                    
                    self.badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
                }
                
                
            case .halfHour:
                for count in 1...(endHour - startHour) * 2 + 1 {
                    
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
                    dateInfo.weekday = weekday
                    dateInfo.timeZone = .current
                    
                    print(">>>> hour: ", hour)
                    print(">>>> minute: ", minute)
                    print(">>>> weekday: ", weekday)
                    
                    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                    let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: notificationTrigger)
                    
                    UNUserNotificationCenter.current().add(notificationRequest)
                    
                    self.badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
                }
                
                
            case .quarterHour:
                for count in 1...(endHour - startHour) * 4 + 1 {
                    
                    // 다 분으로 계산하고 마지막에 시로 바꿔줌
                    let totalMinute = 15 * (count - 1)
                    var hour = startHour
                    var minute = 0
                    
                    if totalMinute >= 60 {
                        hour = startHour + (Int(totalMinute / 60))
                    }
                    
                    if count % 4 == 0 && count-1 % 3 == 0 {
                        minute = 45
                    } else if count % 3 == 0 {
                        minute = 30
                    } else if count % 2 == 0 {
                        minute = 15
                    }
                    
                    /*
                     120min example:
                     
                     9   915.   930.   945.    10    1015.   1030    1045.   11
                     0.   1.    2.     3.     4.      5.      6.      7.     8
                     0    15.   30     45.    60.     75.     90.    105.    120
                     */
                    
                    var dateInfo = DateComponents()
                    dateInfo.hour = hour
                    dateInfo.minute = minute
                    dateInfo.weekday = weekday
                    dateInfo.timeZone = .current
                    
                    print(">>>> hour: ", hour)
                    print(">>>> minute: ", minute)
                    print(">>>> weekday: ", weekday)
                    
                    
                    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                    let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: notificationTrigger)
                    
                    UNUserNotificationCenter.current().add(notificationRequest)
                    
                    self.badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
                }
                
                
            case .tenMinutes:
                for count in 0...(endHour - startHour) * 5 + 1 {
                    
                    // 다 분으로 계산하고 마지막에 시로 바꿔줌
                    let totalMinute = 10 * count
                    var hour = startHour
                    var minute = 0
                    
                    if totalMinute >= 60 {
                        hour = startHour + (Int(totalMinute / 60))
                    } else {
                        minute = totalMinute
                    }
                    
                    if totalMinute % 60 == 0 {
                        minute = 0
                    }
                    
                    /*
                     120min example:
                     
                     9  910.  920.  930.  940  950   10   1010.  1020  1030   1040   1050   11
                     0.  1.    2.    3.    4.   5.   6.    7.     8      9     10     11    12
                     0   10.   20   30.   40.   50.  60.   70.    80    90     100    110   120
                     */
                    
                    var dateInfo = DateComponents()
                    dateInfo.hour = hour
                    dateInfo.minute = minute
                    dateInfo.weekday = weekday
                    dateInfo.timeZone = .current
                    
                    print(">>>> hour: ", hour)
                    print(">>>> minute: ", minute)
                    print(">>>> weekday: ", weekday)
                    
                    
                    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                    let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: notificationTrigger)
                    
                    UNUserNotificationCenter.current().add(notificationRequest)
                    
                    self.badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
                    
                }
            }
            
        }
        
        notificationCenter.getPendingNotificationRequests { messages in
            print("Notification Schdule Complete: ", messages)
        }
    }
    
    
    
    
    // MARK: - cancelNotification (Method)
    /// 예약이 된 모든 알림 요청을 삭제합니다.
    public func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
    
    
    
    /* 리팩토링에 쓰일 함수 리스트 */
    
    // MARK: - notificationCenter init
    private func initNotificationCenter() {
        notificationCenter.delegate = self
    }
    
    // MARK: - notification content
    private func makeNotificationContent(with title: String) {
        notificationContent.title = title
        notificationContent.subtitle = "자세를 바로잡아주세요!"
        notificationContent.sound = UNNotificationSound.default
    }
    
    
    // MARK: - create notifcation target date
    private func scheduleNotification(
        weekday: Int,
        startHour: Int,
        endHour: Int,
        frequency: MinuteInterval) -> DateComponents {
            
            let hour = startHour // + count
            let minute = 0 // frequency.rawValue * count
            
            var dateInfo = DateComponents()
            dateInfo.hour = hour
            dateInfo.minute = minute
            dateInfo.weekday = weekday
            dateInfo.timeZone = .current
            
            return dateInfo
        }
    
    
    // MARK: - create notifcation request
    private func requestNotification(with dateInfo: DateComponents) -> UNNotificationRequest {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        return request
    }
    
    
}





