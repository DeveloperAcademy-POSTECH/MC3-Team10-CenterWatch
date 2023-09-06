//
//  MainView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/25.
//

import SwiftUI
import FirebaseAnalytics

struct MainView: View {
    
    var watchConnecter = WCSettingMobile()
    
    @StateObject private var localNotificationManager = LocalNotificationManager()
    @AppStorage("isNotiAuthorized") var isNotiAuthorized = true
    @State var settings = Setting()
    
    @StateObject var toggleState = ToggleStateModel()
    @ObservedObject var manager = MotionManager()
    @State private var showModal = false
   
    /// 하루만 알림 끄기
    @State private var animationPaused = false
    @State private var grayscaleValue: Double = 0.0
    
    
    //하루 알림 끄기시 없어지는 정보 뷰
    var cellOpacity: Double {
        toggleState.toggleIsOn ? 0 : 1
    }
    
    var body: some View {
        
        VStack {
            DailyNotiToggleRow(toggleIsOn: $toggleState.toggleIsOn)
                .onChange(of: toggleState.toggleIsOn) { newValue in
                    let weekdays = settings.selectedDaysInt
                    let startHour = settings.selectedStartHour
                    let endHour = settings.selectedEndHour
                    let frequency = settings.selectedFrequency
                    localNotificationManager.toggleMessage(toggleState: newValue, weekdays: weekdays, startHour: startHour, endHour: endHour, frequency: frequency)
                    
                    /// Firebase Analytics
                    Analytics
                        .logEvent("event_name",
                                  parameters: ["toggle_On" : "notification paused"])
                }
            
            Divider().padding(.horizontal)
            
            CharacterAnimation(animationPaused: $toggleState.animationPaused, grayscale: $toggleState.grayscaleValue)
                .padding(.bottom, 16)
            
            bottomCell()
        }
        .navigationBarHidden(true)
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.08))
        .onAppear {
            let isAuthorized = UserDefaults.standard.bool(forKey: "isNotiAuthorized")
            
            print("isNotiAuthorized: ", isNotiAuthorized)
            print("isAuthorized: ", isAuthorized)
            
            checkIfFirstInApp()
            
            self.toggleState.toggleIsOn = UserDefaults.standard.bool(forKey: "toggleIsOn")

             for weekday in settings.selectedDays {
                 let index = settings.selectedDays.firstIndex(of: weekday)
                 let weekdayIndex = index ?? 0 - 1
                 if !settings.selectedDaysInt.isEmpty {
                     if settings.selectedDaysInt.contains(weekdayIndex) {
                         settings.selectedDays[weekdayIndex].selected = true
                     } else {
                         settings.selectedDays[weekdayIndex].selected = false
                     }
                 }
             }
            
            /// UserDefaults에 저장된 데이터
            self.settings.selectedStartHour = UserDefaults.standard.integer(forKey: "notificationStartHour")
            self.settings.selectedEndHour = UserDefaults.standard.integer(forKey: "notificationEndHour")
            self.settings.selectedFrequency = NotiInterval(rawValue: UserDefaults.standard.integer(forKey: "notificationFrequency")) ?? .hour
           
            /// 저장된 요일 값에 해당 요일이 존재하면 저장된 값을 재할당
            if let arr = UserDefaults.standard.array(forKey: "notificationWeekdays") as? [Int] {
                for int in 0...settings.selectedDays.count {
                    if arr.contains(int + 1) {
                        settings.selectedDays[int].selected = true
                    }
                }
            }
            
            /// 선택된 요일이 없을 경우, 평일을 초기값으로 할당
            let selectionArr = settings.selectedDays.map({ $0.selected })
            if !selectionArr.contains(true) {
                // TODO: int 값 말고 요일 string 값으로 로직 변경
                for i in 0...5 {
                    settings.selectedDays[i].selected = true
                }
            }
            
            /// 실행시 워치에 값 전송
            watchConnecter.session.sendMessage(["startHour" : [settings.selectedStartHour, settings.selectedEndHour, settings.selectedFrequency.rawValue]], replyHandler: nil)
        }
    }

    //MARK: 노티 허용을 하지 않았을 때 <시스템 설정>으로 보내는 화면입니다.
    @ViewBuilder
    private func pleaseTurnOnTheNotiView() -> some View {
        VStack(spacing: 25) {
            FontView(String(localized: "Oh...! Fynn wants to send a message. Activation requires notification settings."), .pretendardBold, 19, .white, 1)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
            
            Button {
                openAppSettings()
                
            } label: {
                
                FontView(String(localized: "System Settings"), .pretendardBold, 17, .white, 1)
                    .padding(12)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(14)
            
        }
    }
    
    //MARK: 메인 뷰 하단 셀
    @ViewBuilder
    private func bottomCell() -> some View {
        ZStack {
            
            if isNotiAuthorized {
                SettingInfomationCell(settings: $settings)
                    .opacity(cellOpacity)
                    .shadow(radius: 6)
                    .parallaxMotion(with: manager, magnitude3d: 20, magnitude2d: 5)
            } else {
                pleaseTurnOnTheNotiView()
            }
            
            if toggleState.toggleIsOn {
                IfDailyNotiOffCell()
                    .opacity(1-cellOpacity)
            }
        }
        .cornerRadius(20)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .shadow(radius: 3)
        .parallaxMotion(with: manager, magnitude3d: 20, magnitude2d: 25)
    }
    
    // MARK: 앱의 시스템 설정 페이지로 이동합니다.
    private func openAppSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



