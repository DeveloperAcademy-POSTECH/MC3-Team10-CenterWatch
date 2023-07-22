//
//  AlarmSettingModalView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/17.
//

import SwiftUI

struct SelectedDay: Equatable, Hashable {
    let day: String
    var selected: Bool
}

struct Setting {
    var selectedDays: [SelectedDay] = [
        SelectedDay(day: "일", selected: false),
        SelectedDay(day: "월", selected: true),
        SelectedDay(day: "화", selected: true),
        SelectedDay(day: "수", selected: true),
        SelectedDay(day: "목", selected: true),
        SelectedDay(day: "금", selected: true),
        SelectedDay(day: "토", selected: false)
    ]
    
    
    var startTime: Date = {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 00

        return calendar.date(from: dateComponents)!
    }()
    var endTime: Date = {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = 18
        dateComponents.minute = 00

        return calendar.date(from: dateComponents)!
    }()
    var notificationCycle: String = "10분"
    var pokeNotification: Bool = true
}



struct ModalView: View {
    @Environment(\.presentationMode) var presentation
   
    let notificationCycles: [LocalNotificationManager.MinuteInterval] = [.tenMinutes, .quarterHour, .halfHour, .hour]
    
    @State var settings = Setting()
    @State private var selectedStartHour: Int = 0
    @State private var selectedEndHour: Int = 0
    @State private var selectedFrequency: LocalNotificationManager.MinuteInterval = .tenMinutes
    
    @StateObject private var localNotificationManager = LocalNotificationManager()
   
    // MARK: - selectedDaysInt (Computed Property)
    /// setLocalNotification 함수에 전달하기 위해 selectedDays 데이터를 [Int]의 형태로 가공합니다.
    var selectedDaysInt: [Int] {
        var daysConvertedToInt: [Int] = []
        for selectedDay in settings.selectedDays {
            if selectedDay.selected {
                daysConvertedToInt.append((settings.selectedDays.firstIndex(of: selectedDay) ?? 0) + 1)
            }
        }
        return daysConvertedToInt
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("자동 알림")) {
                    
                    SelectNotificationDay(selectedDays: $settings.selectedDays)

                    /// 시간 선택지를 정각으로 제한하기 위해 DatePicker 대신 Picker를 커스텀해 사용
                    HStack {
                        Text("시작 시간")
                        Spacer()
                        CustomHourPicker(selectedHour: $selectedStartHour)
                            .frame(width: 200, height: 80)
                    }
                    
                    HStack {
                        Text("종료 시간")
                        Spacer()
                        CustomHourPicker(selectedHour: $selectedEndHour)
                            .frame(width: 200, height: 80)
                    }
                    
                    Picker("알림 빈도", selection: $selectedFrequency) {
                        ForEach(notificationCycles, id: \.self) { interval in
                            Text("\(interval.rawValue)분")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(height: 60)
                    .padding(.trailing, 8)
                }
                

                // FIXME: - 찌르기 관련 코드 임시 주석 처리
                /*
                 Section(header: Text("콕 찌르기")) {
                     Toggle("알림 받기", isOn: $settings.pokeNotification)
                 }
                 */
                
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
                        // 선택된 스케줄을 파라미터로 전달하고 푸시 알림 요청
                        localNotificationManager.setLocalNotification(weekdays: selectedDaysInt,
                                                                      startHour: selectedStartHour,
                                                                      endHour: selectedEndHour,
                                                                      frequency: selectedFrequency)
                        print("눌렷음")
                        print("---> weekdays: ", selectedDaysInt)
                        print("---> startHour: ", selectedStartHour)
                        print("---> endHour: ", selectedEndHour)
                        print("---> frequency: ", selectedFrequency)
                        
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Text("완료")
                    }
                }
            }
        }
    }
}



//struct AlarmSettingModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalView()
//    }
//}
