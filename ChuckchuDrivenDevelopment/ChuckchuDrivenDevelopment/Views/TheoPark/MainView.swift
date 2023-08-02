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
        .init(day: "일", selected: false),
        .init(day: "월", selected: true),
        .init(day: "화", selected: true),
        .init(day: "수", selected: true),
        .init(day: "목", selected: true),
        .init(day: "금", selected: true),
        .init(day: "토", selected: false)
    ]
}

struct MainView: View {
    
    @ObservedObject var manager = MotionManager()
    @StateObject private var localNotificationManager = LocalNotificationManager()
    @State var settings = Setting()
    
    /// UI에서 사용자가 선택한 데이터
    @State private var selectedStartHour: Int = 0
    @State private var selectedEndHour: Int = 0
    @State private var selectedFrequency: TimeInterval = .hour
    @State private var nextTargetWeekday: Int = 1
    
    /// 하루만 알림 끄기
    @State private var animationPaused = false
    @State private var grayscaleValue: Double = 0.0
    @State var toggleIsOn: Bool = false
    
    /// 모달뷰 띄우기
    @State private var showModal = false
    
    /// UserDefaults에 저장된 데이터
    private var storedStartHour = UserDefaults.standard.integer(forKey: "notificationStartHour")
    private var storedEndHour = UserDefaults.standard.integer(forKey: "notificationEndHour")
    private var storedFrequency = UserDefaults.standard.integer(forKey: "notificationFrequency")
    private var storedWeekdays = UserDefaults.standard.array(forKey: "notificationWeekdays") as? [Int]
    
    
    // MARK: - Save Notification Data (Method)
    // 화면 재진입 시 이전 데이터를 다시 그려주기 위해 화면 이탈 전 사용자 설정 값을 UserDefaults에 저장합니다.
    func saveNotificationData() {
        UserDefaults.standard.set(selectedStartHour, forKey: "notificationStartHour")
        UserDefaults.standard.set(selectedEndHour, forKey: "notificationEndHour")
        UserDefaults.standard.set(selectedDaysInt, forKey: "notificationWeekdays")
        UserDefaults.standard.set(selectedFrequency.rawValue, forKey: "notificationFrequency")
    }
    
    
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
    
    
    //하루 알림 끄기시 없어지는 정보 뷰
    var cellOpacity: Double {
        toggleIsOn ? 0 : 1
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
            DayOffToggleView(toggleIsOn: $toggleIsOn)
            
            Divider()
                .padding(.leading)
                .padding(.trailing)
            
            CharacterAnimation(animationPaused: $animationPaused, grayscale: $grayscaleValue)
                .padding(.bottom, 16)
            
            // MARK: - 알림 설정 세부사항
            
            ZStack {
                
                NotificationSettingsCell(selectedStartHour: $selectedStartHour, selectedEndHour: $selectedEndHour, selectedFrequency: $selectedFrequency, selectedWeekdays: $settings.selectedDays, settings: $settings)
                    .opacity(cellOpacity)
                
                
                DayOffActiveView()
                    .opacity(1-cellOpacity)
                    .onChange(of: toggleIsOn) { newValue in
                        // Update animationPaused and grayscaleValue based on toggleIsOn
                        if newValue {
                            animationPaused = true
                            grayscaleValue = 1.0
                        } else {
                            animationPaused = false
                            grayscaleValue = 0.0
                        }
                    }
                
            }
            .background(Color.init(hue: 0, saturation: 0, brightness: 0.12))
            .cornerRadius(20)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .shadow(radius: 6)
            .modifier(ParallaxMotionModifier(manager: manager, magnitude3d: 20, magnitude2d: 25))
            
            Spacer()
        }
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.08))
        .onAppear {
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
    
    //MARK: 노티 허용을 하지 않았을 때 <시스템 설정>으로 보내는 화면입니다.
    //    var pleaseTurnOnTheNotiView: some View {
    //        VStack(spacing: 25) {
    //            Text("앗...!\n핀이 메세지를 보내고 싶대요.\n활성화는 알림 설정이 꼭 필요해요.")
    //                .multilineTextAlignment(.center)
    //                .font(Font(UIFont(name: "Pretendard-Bold", size: 19)!))
    //                .lineSpacing(8)
    //
    //            Button {
    //                //TODO: 여기에 시스템 설정으로 ..
    //            } label: {
    //
    //                Text("시스템 설정")
    //                    .font(Font(UIFont(name: "Pretendard-Bold", size: 17)!))
    //
    //                    .padding(12)
    //            }
    //            .buttonStyle(.borderedProminent)
    //            .cornerRadius(14)
    //
    //        }
    //    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
