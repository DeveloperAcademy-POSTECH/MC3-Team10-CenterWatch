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
    
    enum MinuteInterval: Int {
        case tenMinutes = 10
        case quarterHour = 15
        case halfHour = 30
        case hour = 60
    }
    
    
    // MARK: - customWeekdayTrigger (Method)
    /// 요일별 푸시 알림 예약을 생성하고 알림을 요청합니다.
    func customWeekdayTrigger(weekday: Int,
                              startHour: Int,
                              endHour: Int,
                              frequency: MinuteInterval) {
        

        /* Defining Notification Contents */
        /// 푸시 알림의 내용 정의
        let content = UNMutableNotificationContent()
        content.title = "🐢바른 자세에 바른 정신이 깃든다🐢"
        content.subtitle = "허리를 펼 시간이에요. 기지개 한 번 해주시고 자세를 바로잡아주세요!"
        content.sound = .default
        content.badge = 1
        
        
        /* Defining Notification Triggers */
        /// 알림 trigger 정의: 푸시 알림이 발송되어야 하는 시간대를 커스텀 trigger를 통해 정의
        let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(frequency.rawValue*60), repeats: true)
        
        /// 알림 발송 요청: 현재 시간과 startHour/endHour를 비교한 후, 현재가 설정된 범위 내라면 인터벌 trigger 생성 후 알림 발송
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date) // 참고 - 새벽 12시는 0으로 표기된다 (0시~23시)
        while hour >= startHour && hour <= endHour {
            let intervalRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: timeIntervalTrigger)
            UNUserNotificationCenter.current().add(intervalRequest)
        }
        
    }
        
    
    // MARK: - setLocalNotification (Method)
    /// 맞춤 설정된 스케줄을 토대로 로컬 알림을 발송합니다.
    func setLocalNotification(weekdays: [Int], startHour: Int, endHour: Int, frequency: MinuteInterval) {
        let manager = LocalNotificationManager.instance
        
        for weekday in weekdays {
            manager.customWeekdayTrigger(weekday: weekday, startHour: startHour, endHour: endHour, frequency: frequency)
        }
    }

    

    // TODO: - 알림 끄기 파트에 연결
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
}


