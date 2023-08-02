//
//  AlarmSettingModalView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/17.
//

import SwiftUI

struct ModalView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @Binding var selectedStartHour: Int
    @Binding var selectedEndHour: Int
    @Binding var selectedFrequency: TimeInterval
    @Binding var selectedWeekdays: [SelectedDay]
    @Binding var settings: Setting
    @Binding var textOpacity: Double
    
    @State private var nextTargetWeekday: Int = 1
    @State private var isRangeCorrect: Bool = false
    
    @State private var isCompleted: Bool = false //변경 감지를 위한 프로퍼티
    
    @State var isInputCorrect: Bool = false
    @State var isSubmitted: Bool = false
    @State var isIntervalCorrect: Bool = true
    let notificationCycles: [TimeInterval] = [.hour, .twoHour, .threeHour]
    
    @StateObject var localNotificationManager = LocalNotificationManager()
    
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
            VStack {
                HStack {
                    Text("알림 주기")
                        .font(Font(UIFont(name: "Pretendard-Bold", size: 18)!))
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Picker("알림 주기", selection: $selectedFrequency) {
                        ForEach(notificationCycles, id: \.self) { interval in
                            Text("\(interval.rawValue / 60)시간")
                                .font(Font(UIFont(name: "Pretendard-Bold", size: 18)!))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.trailing, 10)
                    .font(Font(UIFont(name: "Pretendard-Bold", size: 18)!))
                    .onTapGesture {
                        let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                        impactHeavy.impactOccurred()
                    }
                    
                }
                .background(Color.init(hue: 0, saturation: 0, brightness: 0.16))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                
                VStack {
                    
                    TimePickerView(selectedStartHour: $selectedStartHour, selectedEndHour: $selectedEndHour)
                        .padding(EdgeInsets(top: 8, leading: -6, bottom: 0, trailing: -6))
                    
                    
                    Divider()
                        .background(Color.white).opacity(0.2)
                        .padding(.leading)
                    
                    VStack {
                        HStack {
                            Text("요일")
                                .font(Font(UIFont(name: "Pretendard-Bold", size: 18)!))
                                .foregroundColor(.white)
                                .padding(.leading, 18)
                                .padding(.top, 10)
                            
                            Spacer()
                        }
                        
                        SelectNotificationDay(selectedDays: $selectedWeekdays)
                            .padding(EdgeInsets(top: 4, leading: 6, bottom: 16, trailing: 0))
                    }
                }
                .background(Color.init(hue: 0, saturation: 0, brightness: 0.16))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                .navigationTitle("알림 설정").bold()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentation.wrappedValue.dismiss()
                        } label: {
                            Text("취소")
                                .font(Font(UIFont(name: "Pretendard-Medium", size: 16)!))
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            presentation.wrappedValue.dismiss()
                            textOpacity = 0.2
                            withAnimation(.easeInOut.delay(0.2)) {
                                textOpacity = 1
                            }
                            if !selectedDaysInt.isEmpty {
                                localNotificationManager.cancelNotification()
                                let currentWeekday = getCurrentWeekday()
                                // 경우 1. 현재의 요일이 선택된 요일에 포함된다면 해당 요일의 알림을 만들고,
                                if selectedDaysInt.contains(currentWeekday) {
                                    nextTargetWeekday = currentWeekday
                                    /// 경우 2. 포함되지 않는다면 현재와 가장 가까운 요일의 알림을 만든다
                                    // FIXME: 조건문을 분리 후 코드 깔끔하게 변경
                                } else {
                                    nextTargetWeekday = getNearestWeekday(from: selectedDaysInt)
                                }
                                
                                // 선택된 스케줄을 파라미터로 전달하고 푸시 알림 요청
                                localNotificationManager.setLocalNotification(
                                    weekday: nextTargetWeekday,
                                    startHour: selectedStartHour,
                                    endHour: selectedEndHour,
                                    frequency: selectedFrequency
                                )}

                            /// 변경된 데이터 UserDefaults에 저장
                            saveNotificationData()
                            isSubmitted = true
                        } label: {
                            Text("완료")
                                .font(Font(UIFont(name: "Pretendard-Medium", size: 16)!))
                        }
                        .disabled(!isCompleted)
                    }
                }
                .onChange(of: selectedStartHour) { newValue in
                    isCompleted = true
                }
                .onChange(of: selectedEndHour) { newValue in
                    isCompleted = true
                }
                .onChange(of: selectedFrequency) { newValue in
                    isCompleted = true
                }
                .onChange(of: selectedWeekdays) { newValue in
                    isCompleted = true
                }
                Spacer()
            }
        }
    }
}




//struct ModalView_Previews: PreviewProvider {
//    // Define some example @State variables to be used in the preview
//    @State static var selectedStartHour: Int = 8
//    @State static var selectedEndHour: Int = 18
//    @State static var selectedFrequency: MinuteInterval = .halfHour
//    @State static var selectedWeekdays: [SelectedDay] = [
//        SelectedDay(day: "일", selected: true),
//        SelectedDay(day: "월", selected: true),
//        SelectedDay(day: "화", selected: true),
//        SelectedDay(day: "수", selected: true),
//        SelectedDay(day: "목", selected: true),
//        SelectedDay(day: "금", selected: true),
//        SelectedDay(day: "토", selected: true)
//    ]
//    @State static var settings = Setting()
//
//    static var previews: some View {
//        ModalView(
//            selectedStartHour: .constant(8),
//            selectedEndHour:.constant(18),
//            selectedFrequency: $selectedFrequency,
//            selectedWeekdays: $selectedWeekdays,
//            settings: $settings
//        )
//        .preferredColorScheme(.dark)
//    }
//}


//struct AlarmSettingModalView_Previews: PreviewProvider {
//
//    @State var settingss = Setting()
//
//    static var previews: some View {
//        ModalView(selectedStartHour: .constant(6), selectedEndHour: .constant(10), selectedFrequency: .constant(.tenMinutes), selectedWeekdays: .constant([
//            SelectedDay(day: "일", selected: false),
//            SelectedDay(day: "월", selected: true),
//            SelectedDay(day: "화", selected: true),
//            SelectedDay(day: "수", selected: true),
//            SelectedDay(day: "목", selected: true),
//            SelectedDay(day: "금", selected: true),
//            SelectedDay(day: "토", selected: false)
//        ]), settings: .constant(settingss))
//
//        .preferredColorScheme(.dark)
//    }
//}
