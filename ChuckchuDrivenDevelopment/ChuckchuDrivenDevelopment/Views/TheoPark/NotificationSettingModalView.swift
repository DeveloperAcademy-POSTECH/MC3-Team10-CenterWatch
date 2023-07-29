//
//  AlarmSettingModalView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/17.
//

import SwiftUI

//struct SelectedDay: Equatable, Hashable {
//    let day: String
//    var selected: Bool
//}

//struct Setting {
//    var selectedDays: [SelectedDay] = [
//        SelectedDay(day: "일", selected: false),
//        SelectedDay(day: "월", selected: true),
//        SelectedDay(day: "화", selected: true),
//        SelectedDay(day: "수", selected: true),
//        SelectedDay(day: "목", selected: true),
//        SelectedDay(day: "금", selected: true),
//        SelectedDay(day: "토", selected: false)
//    ]
//}


struct ModalView: View {
    @Environment(\.presentationMode) var presentation
   
    let notificationCycles: [MinuteInterval] = [.tenMinutes, .quarterHour, .halfHour, .hour]
    
    @State var settings = Setting()
    @State private var selectedStartHour: Int = 0
    @State private var selectedEndHour: Int = 0
    @State private var selectedFrequency: MinuteInterval = .tenMinutes
    
    @State private var showAlert: Bool = false
    
    @StateObject private var localNotificationManager = LocalNotificationManager()
    
    
    // MARK: - saveNotificationData (Method)
    /// 화면 재진입 시 이전 데이터를 다시 그려주기 위해 화면 이탈 전 사용자 설정 값을 UserDefaults에 저장합니다.
     func saveNotificationData() {
         UserDefaults.standard.set(selectedStartHour, forKey: "notificationStartHour")
         UserDefaults.standard.set(selectedEndHour, forKey: "notificationEndHour")
         UserDefaults.standard.set(selectedDaysInt, forKey: "notificationWeekdays")
         UserDefaults.standard.set(selectedFrequency.rawValue, forKey: "notificationFrequency")
     }
    
   
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
                        if selectedEndHour > selectedStartHour {
                            /// 선택된 스케줄을 파라미터로 전달하고 푸시 알림 요청
                            localNotificationManager.setLocalNotification(
                                weekday: selectedDaysInt[0],
                                startHour: selectedStartHour,
                                endHour: selectedEndHour,
                                frequency: selectedFrequency
                            )
                           
                            /// 변경된 데이터 UserDefaults에 저장
                            saveNotificationData()
                            
                        
                            print("--------View--------")
                            print("눌렷음")
                            print("---> selected weekdays: ", selectedDaysInt)
                            print("---> selected startHour: ", selectedStartHour)
                            print("---> selected endHour: ", selectedEndHour)
                            print("---> selected frequency: ", selectedFrequency)
                            
                            presentation.wrappedValue.dismiss()
                        } else {
                            showAlert = true
                        }
                    } label: {
                        Text("완료")
                    }
                    .alert("'종료 시간'을 '시작 시간'보다 \n늦은 시간대로 맞춰주세요 ⏰", isPresented: $showAlert) {
                        Button("확인", role: .cancel) { }
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
