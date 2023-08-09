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
    
    private let calendar = Calendar.current
    private let notificationCenter = UNUserNotificationCenter.current()
    private let notificationContent = UNMutableNotificationContent()
    private let notificationTitle = NotificationTitle().variations
    
    
    // MARK: - Request Notification Permission (Method)
    /// 시스템상의 알림 허용을 요청합니다.
    public func requestNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error {
                print(error)
            }
        }
    }
}


// MARK: - 사용자 설정 알림 관련
extension LocalNotificationManager {
    
    // MARK: - Set Local Notification (Method)
    /// 맞춤 설정된 스케줄을 토대로 로컬 알림을 발송합니다.
    public func setLocalNotification(
        weekdays: [Int],
        startHour: Int,
        endHour: Int,
        frequency: NotiInterval
    ) {
        requestWeekdayTrigger(
            weekdays: weekdays,
            startHour: startHour,
            endHour: endHour,
            frequency: frequency)
    }
    
    
    // MARK: - Request Weekday Trigger (Method)
    /// 요일별 푸시 알림 예약을 생성하고 알림을 요청합니다.
    /// parameter: 알림 요일 설정 값 (weekday)  |  시작 시간 값 (startHour)  |  종료 시간 값 (endHour)  |  알림 빈도 설정 값 (frequency)
    private func requestWeekdayTrigger(
        weekdays: [Int],
        startHour: Int,
        endHour: Int,
        frequency: NotiInterval
    ) {
        initNotificationCenter()
        
        /// 0시 -> 24시로 계산되게 하기
        var endHour = endHour
        if endHour == 0 {
            endHour = 24
        }
        
        for weekday in weekdays {
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
                
                
            case .twoHour:
                /// startHour에서 증가하는 인터벌 알림 예약 생성 및 요청
                for count in 1...((endHour - startHour) / 2) + 1 { // 알림의 반복 횟수
                    
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
                
            case .threeHour:
                /// startHour에서 증가하는 인터벌 알림 예약 생성 및 요청
                for count in 1...((endHour - startHour) / 3) + 1 { // 알림의 반복 횟수
                    
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
            }
            
        }
        /// 요청된 알림 확인
        notificationCenter.getPendingNotificationRequests { messages in
            print("Notification Schdule Complete: ", messages)
        }
    }
    
    // MARK: - Cancel Notification (Method)
    /// 예약이 된 모든 알림 요청을 삭제합니다.
    public func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
    // MARK: - NotificationCenter Init (Method)
    private func initNotificationCenter() {
        notificationCenter.delegate = self
    }
    
    // MARK: - Notification Content (Method)
    private func makeNotificationContent(with titles: [String]) {
        notificationContent.title = titles.randomElement() ?? "허리피라우🐢"
        notificationContent.body = "자세를 바로잡아주세요!"
        notificationContent.categoryIdentifier = "alarm"
        notificationContent.userInfo = ["허리핀": "핀"]
        notificationContent.sound = UNNotificationSound.default
    }
}



// MARK: - 하루 휴식 알림 관련
extension LocalNotificationManager {
    
    // MARK: - Toggle Notification (Method)
    /// '하루만 알림끄기' 토글의 활성화 여부에 따라 각 지정된 함수를 호출합니다.
    public func toggleMessage(toggleState: Bool, weekdays: [Int], startHour: Int, endHour: Int, frequency: NotiInterval) {
        if toggleState {
            setNextDayNotification()
        } else {
            setLocalNotification(weekdays: weekdays, startHour: startHour, endHour: endHour, frequency: frequency)
            
        }
    }
    
    // MARK: - Set Next Day Notification (Method)
    /// '하루만 알림 끄기' 토글을 활성화시킬 때 24시간 후 발송되는 알림을 생성합니다.
    public func setNextDayNotification() {
        
        /// 이전 알림 예약 전체 취소
        cancelNotification()
        
        /// 새로운 알림의 내용
        notificationContent.title = "약속한 하루가 지났어요!"
        notificationContent.body = "알림을 재설정하고 다시 핀의 메세지를 받아보세요 🐢"
        notificationContent.categoryIdentifier = "alarm"
        notificationContent.userInfo = ["허리핀": "핀"]
        notificationContent.sound = UNNotificationSound.default
        
        /// 알림이 24시간 뒤 보내지도록 예약
        let timeInterval = TimeInterval(24 * 60 * 60) // 24시간을 초 단위로 계산
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        /// 알림 요청 전송
        self.notificationCenter.add(request)
    }
}
