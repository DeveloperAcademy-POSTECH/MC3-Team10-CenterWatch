//
//  AlarmSettingModalView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/17.
//

import SwiftUI

//struct SelectedDay {
//    let day: String
//    var selected: Bool
//}
//
//struct Setting {
//    var selectedDays: [SelectedDay] = [
//        SelectedDay(day: "월", selected: true),
//        SelectedDay(day: "화", selected: true),
//        SelectedDay(day: "수", selected: true),
//        SelectedDay(day: "목", selected: true),
//        SelectedDay(day: "금", selected: true),
//        SelectedDay(day: "토", selected: false),
//        SelectedDay(day: "일", selected: false)
//    ]
//    
//    var startTime: Date = {
//        let calendar = Calendar.current
//        var dateComponents = DateComponents()
//        dateComponents.hour = 8
//        dateComponents.minute = 00
//
//        return calendar.date(from: dateComponents)!
//    }()
//    var endTime: Date = {
//        let calendar = Calendar.current
//        var dateComponents = DateComponents()
//        dateComponents.hour = 18
//        dateComponents.minute = 00
//
//        return calendar.date(from: dateComponents)!
//    }()
//    var notificationCycle: String = "10분"
//    var pokeNotification: Bool = true
//}

struct ModalView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var settings = Setting()
    let notificationCycles: [String] = ["10분", "15분", "30분", "1시간"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("자동 알림")) {
                    
                    SelectNotificationDay(selectedDays: $settings.selectedDays)
                    
                    DatePicker("시작 시간", selection: $settings.startTime, displayedComponents: [.hourAndMinute])
                    
                    DatePicker("종료 시간", selection: $settings.endTime, displayedComponents: [.hourAndMinute])
                    
                    Picker("알림 빈도", selection: $settings.notificationCycle) {
                        ForEach(notificationCycles, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(header: Text("콕 찌르기")) {
                    Toggle("알림 받기", isOn: $settings.pokeNotification)
                }
            }
            .navigationTitle("알림 설정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Text("취소")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Text("완료")
                    }
                }
            }
        }
    }
}

struct NotificationSettingModalView: View {
    @State private var showNotificationSettingModal: Bool = false
    
    var body: some View {
        Button {
            self.showNotificationSettingModal = true
        } label: {
            Text("알림 설정")
        }
        .sheet(isPresented: self.$showNotificationSettingModal) {
            ModalView()
        }
        
    }
}

struct AlarmSettingModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
