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
    
    
    // MARK: - customWeekdayTrigger (Method)
    /// 요일별 푸시 알림 예약을 생성하고 알림을 요청합니다.
    /*
     func requestWeekdayTrigger(weekday: Int,
                               startHour: Int,
                               endHour: Int,
                               frequency: MinuteInterval) {
         

         /* Defining Notification Contents */
         /// 푸시 알림의 내용 정의
         let content = UNMutableNotificationContent()
         content.title = "🐢허리를 펼 시간이에요🐢"
         content.subtitle = "기지개 한 번 해주시고 자세를 바로잡아주세요!"
         content.sound = .default
         var badgeCount: NSNumber?
         content.badge = badgeCount
     
         
         /* Defining Notification Triggers */
         /// 알림 trigger 정의: 푸시 알림이 발송되어야 하는 시간대를 커스텀 trigger를 통해 정의
         let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(frequency.rawValue*60), repeats: true)
         
         /// 알림 발송 요청: 현재 시간과 startHour/endHour를 비교한 후, 현재가 설정된 범위 내라면 인터벌 trigger 생성 후 알림 발송
         let date = Date()
         let calendar = Calendar.current
         let hour = calendar.component(.hour, from: date) // 참고 - 새벽 12시는 0으로 표기된다 (0시~23시)
         let currentWeekday = calendar.component(.weekday, from: date)
         
         let intervalRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: timeIntervalTrigger)

         if hour >= startHour && hour <= endHour && currentWeekday == weekday {
             UNUserNotificationCenter.current().add(intervalRequest)
             print("-----------Manager----------")
             print("인터벌 알림 요청이 발송되었습니다🎉")
             print("hour: ", hour, "| startHour: ", startHour, "| endHour: ", endHour)
             print("weeday: ", weekday, "currentWeekday: ", currentWeekday)
             badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
         } else {
             return
         }
     }
     */
    
    
    
    
    
    // MARK: - 새로운 접근
    /// 설정 완료 버튼 > requestWeekdayTrigger() (요일의 시작하는 시간에 발송되는 알림 예약이 요청됨) > requestIntervalTrigger() (앞전 알림이 도착하면, 예약이 걸린 알림이 없는지 확인하고 인터벌 알림 예약됨) >
    
    
    // 1. 우선 선택된 요일의 가장 첫번째 시간대에 발송되는 알림 예약을 하나 만들고 알림을 요청한다
    
    // MARK: - requestWeekdayTrigger (Method)
    /// 요일별 푸시 알림 예약을 생성하고 알림을 요청합니다.
    /// parameter: 알림 요일 설정 값 (weekday) / 시작 시간 값 (startHour) / 종료 시간 값 (endHour) / 알림 빈도 설정 값 (frequency)
    func requestWeekdayTrigger(weekday: Int,
                              startHour: Int,
                              endHour: Int,
                              frequency: MinuteInterval) {
        
        /// 푸시 알림의 내용 정의
        let content = UNMutableNotificationContent()
        content.title = "🐢허리를 펼 시간이에요🐢"
        content.subtitle = "기지개 한 번 해주시고 자세를 바로잡아주세요!"
        content.sound = .default
        content.badge = badgeCount
        
        
        /// 알림 trigger 정의: 푸시 알림이 발송되어야 하는 시간대를 커스텀 trigger를 통해 정의
        let selectedWeekday: DateComponents = DateComponents(hour: startHour, minute: 0, weekday: weekday)
        let openingTrigger = UNCalendarNotificationTrigger(dateMatching: selectedWeekday, repeats: false) // TODO: pending 리스트 비우려고 false 걸긴 했는데 이 다음 주에는 어떻게 반복할 것이냐..
        let openingNotificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: openingTrigger)
        
        /// 알림 발송 요청: 현재 시간과 startHour/endHour를 비교한 후, 현재가 설정된 범위 내라면 인터벌 trigger 생성 후 알림 발송
        UNUserNotificationCenter.current().add(openingNotificationRequest)
        
        self.badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
        
        print("-----------Manager----------")
        print("요일 알림 요청이 발송되었습니다🎉")
        print("startHour: ", startHour, "| endHour: ", endHour, "weeday: ", weekday)
    }
    
    
    
    // 2. 그 예약이 발송되는 시점으로부터 인터벌 알림 예약을 다시 만들고 알림을 요청한다.
    /// UserNotifications을 통해 특정 알림이 발송되었는지에 대한 여부는 파악이 불가능하다. AppDelegate에서 핸들링해야 함.
   
    // MARK: - requestIntervalTrigger (Method)
    /// 요일별 푸시 알림 예약을 생성하고 알림을 요청합니다.
    /// parameter: 알림 빈도 설정 값 (frequency)
    func requestIntervalTrigger(frequency: MinuteInterval) {
        
        let content = UNMutableNotificationContent()
        content.title = "🐢허리를 펼 시간이에요🐢"
        content.subtitle = "기지개 한 번 해주시고 자세를 바로잡아주세요!"
        content.sound = .default
        var badgeCount: NSNumber?
        content.badge = badgeCount
        
        
        /// 알림 trigger 정의: 푸시 알림이 발송되어야 하는 시간대를 커스텀 trigger를 통해 정의
        let intervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(frequency.rawValue*60), repeats: true)
        let intervalNotificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: intervalTrigger)
        
        /// 알림 발송 요청: 현재 시간과 startHour/endHour를 비교한 후, 현재가 설정된 범위 내라면 인터벌 trigger 생성 후 알림 발송
        UNUserNotificationCenter.current().add(intervalNotificationRequest)

        badgeCount = NSNumber(integerLiteral: badgeCount?.intValue ?? 0 + 1)
        
        print("-----------Manager----------")
        print("요일 알림 요청이 발송되었습니다🎉")
        print("frequency: ", frequency)
    }
    
    
    
    // 3. endHour를 마지막으로 intervalTriggerRequest를 끊어내는 게 문제임..
    /// ....
    
    

    
    // MARK: - setLocalNotification (Method)
    /// 맞춤 설정된 스케줄을 토대로 로컬 알림을 발송합니다.
    func setLocalNotification(weekdays: [Int], startHour: Int, endHour: Int, frequency: MinuteInterval) {
        let manager = LocalNotificationManager.instance
        
        for weekday in weekdays {
            manager.requestWeekdayTrigger(weekday: weekday, startHour: startHour, endHour: endHour, frequency: frequency)
        }
    }
    
    
    
    // MARK: - cancelNotification (Method)
    /// 예약이 된 모든 알림 요청을 삭제합니다.
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

}

