//
//  MiniTestingView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/27.
//

import SwiftUI
import UserNotifications

struct MiniTestingView: View {
    var body: some View {
        VStack {
            Button("알림 보내기") {
                sendNotification()
            }
        }
    }
}



func sendNotification() {
   
    let center = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = "Late wake up call"
    content.body = "The early bird catches the worm, but the second mouse gets the cheese."
    content.categoryIdentifier = "alarm"
    content.userInfo = ["customData": "fizzbuzz"]
    content.sound = UNNotificationSound.default
    
    
    let startHour = 14
    let endHour = 18
    let weekday = 5
    let count = 4
    
    let hour = startHour + (count - 1)
    let minute = 0
    
    var dateInfo = DateComponents()
    dateInfo.hour = hour
    dateInfo.minute = minute
    dateInfo.second = 0
    dateInfo.weekday = weekday
    dateInfo.timeZone = .current
    dateInfo.calendar = Calendar.current
   
    let identifier = UUID().uuidString + "\(count)" + "\(weekday)"
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    center.add(request)
    
    center.getPendingNotificationRequests { notifcations in
        for notifcation in notifcations {
            print(">>> notification: ", notifcation)
        }
    }

}



struct MiniTestingView_Previews: PreviewProvider {
    static var previews: some View {
        MiniTestingView()
    }
}
