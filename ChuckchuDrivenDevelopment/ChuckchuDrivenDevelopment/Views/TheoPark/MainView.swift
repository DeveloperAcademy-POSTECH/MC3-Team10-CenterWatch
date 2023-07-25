//
//  MainView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/25.
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
    
    /*
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
     
     */
}


struct MainView: View {
    @State var settings = Setting()
    @State private var selectedStartHour: Int = 0
    @State private var selectedEndHour: Int = 0
    @State private var selectedFrequency: MinuteInterval = .tenMinutes
    @State private var isInputCorrect: Bool = false
    @State private var isSubmitted: Bool = false
    
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
        VStack {
            Spacer()
//            CharacterAnimation()
            Rectangle()
                .fill(.black)
                .frame(height: 300)
                .shadow(color: .blue.opacity(0.2), radius: 40)
            Spacer()


            // MARK: - 알림 설정 세부사항
            NotificationSettingsCell(selectedStartHour: $selectedStartHour,
                                     selectedEndHour: $selectedEndHour,
                                     selectedFrequency: $selectedFrequency,
                                     selectedWeekdays: $settings.selectedDays)
            Spacer()
            
            // MARK: - 알림 설정 버튼
            Button {
                if selectedEndHour > selectedStartHour {
                    /// 이전 알림 요청 삭제
                    localNotificationManager.cancelNotification()
                    
                    /// 선택된 스케줄을 파라미터로 전달하고 푸시 알림 요청
                    localNotificationManager.setLocalNotification(
                        weekdays: selectedDaysInt,
                        startHour: selectedStartHour,
                        endHour: selectedEndHour,
                        frequency: selectedFrequency
                    )
                    
                    print("--------View--------")
                    print("눌렷음")
                    print("---> selected weekdays: ", selectedDaysInt)
                    print("---> selected startHour: ", selectedStartHour)
                    print("---> selected endHour: ", selectedEndHour)
                    print("---> selected frequency: ", selectedFrequency)
                    
                    /// 변경된 데이터 UserDefaults에 저장
                    saveNotificationData()
            
                    isSubmitted = true
                    
                } else {
                    isInputCorrect = true
                }
            } label: {
                Text("알림 설정하기")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .frame(height: 40)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue) // FIXME: 추후 accentColor로 변경
            .cornerRadius(20)
            .padding(16)
            // FIXME: toast message 등으로 UI 변경
            .alert("'종료 시간'을 '시작 시간'보다 \n늦은 시간대로 맞춰주세요 ⏰", isPresented: $isInputCorrect) {
                Button("확인", role: .cancel) { }
            }
            .alert("알림이 설정되었어요! 🤩", isPresented: $isSubmitted) {
                Button("확인", role: .cancel) { }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.08))
        .onAppear {
            /// 뷰의 데이터 UserDefaults의 값으로 대체
            let userDefaults = UserDefaults.standard
            let weekdaysInt = userDefaults.integer(forKey: "notificationWeekdays")
            print("notificationWeekdays data ---> ", weekdaysInt)
            
            if userDefaults.integer(forKey: "notificationStartHour") != nil {
                self.selectedStartHour = userDefaults.integer(forKey: "notificationStartHour")
            }
            if userDefaults.integer(forKey: "notificationEndHour") != nil {
                self.selectedEndHour = userDefaults.integer(forKey: "notificationEndHour")
            }
            if userDefaults.integer(forKey: "notificationFrequency") != nil {
                let frequencyrawValue = userDefaults.integer(forKey: "notificationFrequency")
                self.selectedFrequency = MinuteInterval(rawValue: frequencyrawValue) ?? .hour
            }
           
            
            if userDefaults.integer(forKey: "notificationWeekdays") != nil {
                print("꺄아아아아앙")
                let weekdaysInt = userDefaults.array(forKey: "notificationWeekdays") as? [Int]
                print("weekdaysInt -> ", weekdaysInt ?? 0)
                print("selectedWeekdays -> ", settings.selectedDays)
                for weekday in settings.selectedDays {
                    let index = settings.selectedDays.firstIndex(of: weekday)
                    let weekdayIndex = index ?? 0 - 1
                    if !selectedDaysInt.isEmpty {
                        if selectedDaysInt.contains(weekdayIndex) {
                            settings.selectedDays[weekdayIndex].selected = true
                        } else {
                            settings.selectedDays[weekdayIndex].selected = false
                        }
                    }
                }
            }
        }
    }
}




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
