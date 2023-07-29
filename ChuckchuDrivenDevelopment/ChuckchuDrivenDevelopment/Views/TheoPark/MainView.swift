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
}


struct MainView: View {
    @StateObject private var localNotificationManager = LocalNotificationManager()
    @State var settings = Setting()
    
    /// UI에서 사용자가 선택한 데이터
    @State private var selectedStartHour: Int = 0
    @State private var selectedEndHour: Int = 0
    @State private var selectedFrequency: TimeInterval = .hour
    @State private var nextTargetWeekday: Int = 1
   
    @State private var isRangeCorrect: Bool = false
    @State private var isSubmitted: Bool = false
    @State private var isProceedDisabled: Bool = false
    
    /// UserDefaults에 저장된 데이터
    private var storedStartHour = UserDefaults.standard.integer(forKey: "notificationStartHour")
    private var storedEndHour = UserDefaults.standard.integer(forKey: "notificationEndHour")
    private var storedFrequency = UserDefaults.standard.integer(forKey: "notificationFrequency")
    private var storedWeekdays = UserDefaults.standard.array(forKey: "notificationWeekdays") as? [Int]
    
    
    // MARK: - Save Notification Data (Method)
    /// 화면 재진입 시 이전 데이터를 다시 그려주기 위해 화면 이탈 전 사용자 설정 값을 UserDefaults에 저장합니다.
     func saveNotificationData() {
         UserDefaults.standard.set(selectedStartHour, forKey: "notificationStartHour")
         UserDefaults.standard.set(selectedEndHour, forKey: "notificationEndHour")
         UserDefaults.standard.set(selectedDaysInt, forKey: "notificationWeekdays")
         UserDefaults.standard.set(selectedFrequency.rawValue, forKey: "notificationFrequency")
     }
    
    // MARK: - Selected Days in Int (Computed Property)
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
            CharacterAnimation()
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
                    localNotificationManager.cancelNotification()
                    
                    let currentWeekday = getCurrentWeekday()
                    
                    /// 경우 1. 현재의 요일이 선택된 요일에 포함된다면 해당 요일의 알림을 만들고,
                    if selectedDaysInt.contains(currentWeekday) {
                        nextTargetWeekday = currentWeekday
                    /// 경우 2. 포함되지 않는다면 현재와 가장 가까운 요일의 알림을 만든다
                    // FIXME: 조건문을 분리 후 코드 깔끔하게 변경
                    } else {
                        nextTargetWeekday = getNearestWeekday(from: selectedDaysInt)
                    }
                    
                    /// 선택된 스케줄을 파라미터로 전달하고 푸시 알림 요청
                    localNotificationManager.setLocalNotification(
                        weekday: nextTargetWeekday,
                        startHour: selectedStartHour,
                        endHour: selectedEndHour,
                        frequency: selectedFrequency
                    )
                    
                    /// 변경된 데이터 UserDefaults에 저장
                    saveNotificationData()
            
                    isSubmitted = true
                    
                } else {
                    isRangeCorrect = true
                }
            } label: {
                Text("알림 설정하기")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .frame(height: 40)
            }
            .disabled(isProceedDisabled)
            .buttonStyle(.borderedProminent)
            .tint(.blue) // FIXME: 추후 accentColor로 변경
            .cornerRadius(20)
            .padding(16)
            // FIXME: toast message 등으로 UI 변경
            .alert("'종료 시간'을 '시작 시간'보다 \n늦은 시간대로 맞춰주세요 ⏰", isPresented: $isRangeCorrect) {
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
            if storedStartHour != nil {
                self.selectedStartHour = storedStartHour
            }
            if storedEndHour != nil {
                self.selectedEndHour = storedEndHour
            }
            if storedFrequency != nil {
                let frequencyrawValue = storedFrequency
                self.selectedFrequency = TimeInterval(rawValue: frequencyrawValue) ?? .hour
            }
            
            if storedWeekdays != nil {
                let weekdaysInt = storedWeekdays
                // print("weekdaysInt -> ", weekdaysInt ?? 0)
                // print("selectedWeekdays -> ", settings.selectedDays)
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
