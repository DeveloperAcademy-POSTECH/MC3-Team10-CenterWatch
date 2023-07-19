//
//  AlarmSettingModalView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/17.
//

import SwiftUI

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

struct ModalView: View {
    @Environment(\.presentationMode) var presentation
    @State private var notificationCycle: String = "10분"
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var pokeNotification: Bool = true
    
    let notificationCycles:[String] = ["10분", "15분", "30분", "1시간"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("자동 알림")) {
                    
                    SelectNotificationDay()
                    
                    DatePicker("시작 시간", selection: $startTime, displayedComponents: [.hourAndMinute])
                    
                    DatePicker("종료 시간", selection: $endTime, displayedComponents: [.hourAndMinute])
                    
                    Picker("알림 빈도", selection: $notificationCycle) {
                        ForEach(notificationCycles, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(header: Text("콕 찌르기")) {
                    Toggle("알림 받기", isOn: $pokeNotification)
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

struct AlarmSettingModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
