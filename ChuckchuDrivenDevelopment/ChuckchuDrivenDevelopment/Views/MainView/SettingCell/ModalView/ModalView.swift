//
//  AlarmSettingModalView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/17.
//

import SwiftUI

struct ModalView: View {
    
    var watchConnecter = WCSettingMobile()
    
    @StateObject var localNotificationManager = LocalNotificationManager()
    @Binding var settings: Setting
    
    @Environment(\.presentationMode) var presentation
    @State private var isCompleted: Bool = false //변경 감지를 위한 프로퍼티
    @Binding var textOpacity: Double
    
    var body: some View {
        NavigationView {
            VStack {
                FrequencySettingRow(with: $settings.selectedFrequency, label: String(localized: "Interval Settings"))
                
                VStack {
                    
                    TimePickerRow(selectedStartHour: $settings.selectedStartHour, selectedEndHour: $settings.selectedEndHour)
                        .padding(EdgeInsets(top: 8, leading: -6, bottom: 0, trailing: -6))
                    
                        Divider().padding(.leading)
                            .background(Color.white).opacity(0.2)
                    
                    VStack {
                        HStack() {
                            FontView(String(localized: "Day"), .pretendardBold, 18, .white, 1).padding(.leading, 18).padding(.top, 10)
                            
                                Spacer()
                        }
                        
                        SelectedDayRow(selectedDays: $settings.selectedDays)
                            .padding(EdgeInsets(top: 12, leading: 16, bottom: 16, trailing: 16))
                    }
                }
                .background(Color.init(hue: 0, saturation: 0, brightness: 0.16))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                .navigationTitle(String(localized: "Notification Settings")).bold()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentation.wrappedValue.dismiss()
                        } label: {
                            FontView(String(localized: "Cancel"), .pretendardMedium, 16, .accentColor, 1)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        // MARK: - 설정 완료 버튼
                        Button {
                            presentation.wrappedValue.dismiss()
                            
                            textOpacity = 0.2
                            withAnimation(.easeInOut.delay(0.2)) {
                                textOpacity = 1
                            }
                                
                            changeNotiSetting()
                            
                            watchConnecter.session.sendMessage(["data" : [settings.selectedStartHour, settings.selectedEndHour, settings.selectedFrequency.rawValue]], replyHandler: nil)
                            try? watchConnecter.session.updateApplicationContext(["update" : [settings.selectedStartHour, settings.selectedEndHour, settings.selectedFrequency.rawValue]])
                            
                        } label: {
                            FontView(String(localized: "Confirm"), .pretendardMedium, 16, .accentColor, 1)
                        }
                        .disabled(!isCompleted)
                    }
                }
                .onChange(of: settings.selectedStartHour) { newValue in
                    isCompleted = true
                }
                .onChange(of: settings.selectedEndHour) { newValue in
                    isCompleted = true
                }
                .onChange(of: settings.selectedFrequency) { newValue in
                    isCompleted = true
                }
                .onChange(of: settings.selectedDays) { newValue in
                    isCompleted = true
                }
                
                Spacer()
            }
        }
        .interactiveDismissDisabled()
    }
    
    // MARK: - saveNotificationData (Method)
    /// 화면 재진입 시 이전 데이터를 다시 그려주기 위해 화면 이탈 전 사용자 설정 값을 UserDefaults에 저장합니다.
    private func saveNotificationData() {
        UserDefaults.standard.set(settings.selectedStartHour, forKey: "notificationStartHour")
        UserDefaults.standard.set(settings.selectedEndHour, forKey: "notificationEndHour")
        UserDefaults.standard.set(settings.selectedDaysInt, forKey: "notificationWeekdays")
        UserDefaults.standard.set(settings.selectedFrequency.rawValue, forKey: "notificationFrequency")
    }
    
    private func changeNotiSetting() {
        /// 기존 알림 삭제
        localNotificationManager.cancelNotification()
        
        /// 선택된 스케줄을 파라미터로 전달하고 푸시 알림 요청
        localNotificationManager.setLocalNotification(
            weekdays: settings.selectedDaysInt,
            startHour: settings.selectedStartHour,
            endHour: settings.selectedEndHour,
            frequency: settings.selectedFrequency
        )

        /// 변경된 데이터 UserDefaults에 저장
        saveNotificationData()
    }
}
