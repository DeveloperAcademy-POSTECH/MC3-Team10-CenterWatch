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
    
    let cfURL1 = Bundle.main.url(forResource: "Pretendard-Medium", withExtension: "otf")
    let cfURL2 = Bundle.main.url(forResource: "Pretendard-Bold", withExtension: "otf")
    var PretendardRegular: UIFont
    var PretendardBold: UIFont

    init(){
        CTFontManagerRegisterFontsForURL(cfURL1! as CFURL, CTFontManagerScope.process, nil)
        PretendardRegular = UIFont(name: "Pretendard-Medium", size: 15.0)!
        CTFontManagerRegisterFontsForURL(cfURL2! as CFURL, CTFontManagerScope.process, nil)
        PretendardBold = UIFont(name: "Pretendard-Bold", size: 15.0)!
    }
    
    @State var settings = Setting()
    @State var selectedStartHour: Int = 8
    @State var selectedEndHour: Int = 18
    @State var selectedFrequency: MinuteInterval = .hour
    
    
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
            CharacterAnimation()
            Spacer()
            
            // MARK: - 알림 설정 세부사항
            NotificationSettingsCell(selectedStartHour: $selectedStartHour,
                                     selectedEndHour: $selectedEndHour,
                                     selectedFrequency: $selectedFrequency,
                                     selectedWeekdays: $settings.selectedDays,
                                     settings: $settings)
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.08))
        .onAppear {
            /// 뷰의 데이터 UserDefaults의 값으로 대체
            let userDefaults = UserDefaults.standard
            let weekdaysInt = userDefaults.integer(forKey: "notificationWeekdays")
            // print("notificationWeekdays data ---> ", weekdaysInt)
            
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
                // print("꺄아아아아앙")
                let weekdaysInt = userDefaults.array(forKey: "notificationWeekdays") as? [Int]
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
