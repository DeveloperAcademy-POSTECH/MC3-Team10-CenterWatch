//
//  LocalNotificationTestingView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/23.
//

import SwiftUI

//struct LocalNotificationTestingView: View {
//
//    var body: some View {
//        VStack(spacing: 40) {
//            Button("Send Notificaiton") {
//                // 알림 스케줄 예시: [월/화/수/목] - [아침9시~오후5시] - [10분 가격]
//                manager.sendLocalNotification(weekdays: [2, 3, 4, 5], startHour: 9, endHour: 0, frequency: .tenMinutes)
//            }
//            Button("Scedule Delete") {
//                manager.cancelNotification()
//            }
//
//            Button("Print current hour") {
//                let date = Date()
//                let calendar = Calendar.current
//                let hour = calendar.component(.hour, from: date)
//                print("------>", hour)
//            }
//        }
//        .onAppear {
//            UIApplication.shared.applicationIconBadgeNumber = 0
//        }
//    }
//}
//
//struct LocalNotificationTestingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocalNotificationTestingView()
//    }
//}
