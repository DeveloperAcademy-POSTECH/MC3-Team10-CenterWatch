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
    private let notificationTitle = NotificationTitle().variations.randomElement() ?? "허리피라우🐢"

    var text: NSMutableAttributedString? = NSMutableAttributedString(string: "List of notification requests and it's time\n")
    
    
    
    
    // MARK: - Request Notification Permission (Method)
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
        weekdays: [Int],
        startHour: Int,
        endHour: Int,
        frequency: MinuteInterval
    ) {
        requestWeekdayTrigger(weekdays: weekdays, startHour: startHour, endHour: endHour, frequency: frequency)
    }
    
    
    // MARK: - Request Weekday Trigger (Method)
    /// 요일별 푸시 알림 예약을 생성하고 알림을 요청합니다.
    /// parameter: 알림 요일 설정 값 (weekday)  |  시작 시간 값 (startHour)  |  종료 시간 값 (endHour)  |  알림 빈도 설정 값 (frequency)
    private func requestWeekdayTrigger(
        weekdays: [Int],
        startHour: Int,
        endHour: Int,
        frequency: MinuteInterval
    ) {
        requestNotificationPermission()
        initNotificationCenter()
        makeNotificationContent(with: notificationTitle)
        
   
        for weekday in weekdays {
            /* 빈도 설정으로 들어온 횟수만큼 알림 요청 생성 */
            switch frequency {
            case .hour:
                /// startHour에서 증가하는 인터벌 알림 예약 생성 및 요청
                for count in 1...(endHour - startHour) + 1 { // 알림의 반복 횟수
                    
                    let hour = startHour + (count - 1)
                    let minute = 0
                    
                    var dateInfo = DateComponents()
                    dateInfo.hour = hour
                    dateInfo.minute = minute
                    dateInfo.second = 0
                    dateInfo.weekday = weekday
                    dateInfo.timeZone = .current
                    dateInfo.calendar = calendar
                    
                    /*
                     print(">>>> hour: ", hour)
                     print(">>>> minute: ", minute)
                     print(">>>> weekday: ", weekday)
                     
                     notificationCenter.getPendingNotificationRequests { requests in
                         for request in requests {
                             print(">>> notification: ", request)
                         }
                     }
                     
                     */
                   
                    let identifier = UUID().uuidString + "\(count)" + "\(weekday)"
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                    let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)
                    
                    self.notificationCenter.add(request)
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
                    dateInfo.second = 0
                    dateInfo.weekday = weekday
                    dateInfo.timeZone = .current
                    dateInfo.calendar = calendar
                    
                    print(">>>> hour: ", hour)
                    print(">>>> minute: ", minute)
                    print(">>>> weekday: ", weekday)
                    
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
                    dateInfo.second = 0
                    dateInfo.weekday = weekday
                    dateInfo.timeZone = .current
                    dateInfo.calendar = calendar
                    
                    print(">>>> hour: ", hour)
                    print(">>>> minute: ", minute)
                    print(">>>> weekday: ", weekday)
                    
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
                
                
            case .tenMinutes:
                for count in 1...((endHour - startHour) * 5) + ((endHour - startHour) + 1) {
                    
                    // 다 분으로 계산하고 마지막에 시로 바꿔줌
                    let totalMinute = 10 * (count - 1)
                    var hour = startHour
                    var minute = 0
                    
                    if totalMinute >= 60 {
                        hour = startHour + (Int(totalMinute / 60))
                        minute = totalMinute - (60 * (hour - startHour))
                    } else {
                        minute = totalMinute
                    }
                    
                    if totalMinute % 60 == 0 {
                        minute = 0
                        
                    }
                    
                    /*
                     exception example: range 0:00~2:00
                     
                     0 010 020 030 040 050  1  110 120 130 140 150  2
                     0   1   2   3   4   5   6   7   8   9  10   11  12
                     0  10. 20  30. 40. 50. 60. 70  80  90  100  110 120
                     */
                    
                    /*
                     120min example:
                     
                     9  910.  920.  930.  940  950   10   1010.  1020  1030   1040   1050   11
                     0.  1.    2.    3.    4.   5.   6.    7.     8      9     10     11    12
                     0   10.   20   30.   40.   50.  60.   70.    80    90     100    110   120
                     */
                    
                    
                    var dateInfo = DateComponents()
                    dateInfo.hour = hour
                    dateInfo.minute = minute
                    dateInfo.second = 0
                    dateInfo.weekday = weekday
                    dateInfo.timeZone = .current
                    dateInfo.calendar = calendar
                    
                    print(">>>> hour: ", hour)
                    print(">>>> minute: ", minute)
                    print(">>>> weekday: ", weekday)
                    
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
    
    // MARK: - notificationCenter init
    private func initNotificationCenter() {
        notificationCenter.delegate = self
    }
    
    // MARK: - notification content
    private func makeNotificationContent(with title: String) {
        notificationContent.title = title
        notificationContent.body = "자세를 바로잡아주세요!"
        notificationContent.categoryIdentifier = "alarm"
        notificationContent.userInfo = ["허리피라우": "허우"]
        notificationContent.sound = UNNotificationSound.default
    }
    
    
    /*
     
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
     
     */
    
    
    
    
}










extension LocalNotificationManager {
    
    func handleNotificationAction() {
        // Define the custom actions.
        let resetTimeAction = UNNotificationAction(identifier: "resetNotificationTimeAction",
              title: "알림 시간 재설정 하러 가기",
              options: [])
        // Define the notification type
        let resetTimeActionCategory =
              UNNotificationCategory(identifier: "resetTimeActionCategory",
              actions: [resetTimeAction],
              intentIdentifiers: [],
              hiddenPreviewsBodyPlaceholder: "알림이 너무 자주 오나요?",
              options: .customDismissAction)
        // Register the notification type.
        notificationCenter.setNotificationCategories([resetTimeActionCategory])
    }
}


