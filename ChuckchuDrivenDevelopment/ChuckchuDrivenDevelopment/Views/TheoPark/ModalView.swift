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
    @Binding var selectedFrequency: MinuteInterval
    @Binding var selectedWeekdays: [SelectedDay]
    @Binding var settings: Setting
    
    @State var isInputCorrect: Bool = false
    @State var isSubmitted: Bool = false
    let notificationCycles: [MinuteInterval] = [.tenMinutes, .quarterHour, .halfHour, .hour]
    
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
                        .bold()
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .padding(.leading, 18)
                    
                    Spacer()
                    
                    Picker("알림 주기", selection: $selectedFrequency) {
                        ForEach(notificationCycles, id: \.self) { interval in
                            Text("\(interval.rawValue)분")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.trailing, 10)
                }
                .background(Color.init(hue: 0, saturation: 0, brightness: 0.16))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                Text("시작 시간")
                                    .bold()
                                .foregroundColor(.white)
                                
                                Spacer()
                            }
                            
                            HStack {
                                CustomHourPicker(selectedHour: $selectedStartHour)
                                    .frame(width: 120, height: 120)
                                    
                                
                                Spacer()
                            }
                        }
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 4, trailing: 16))
                        
//                        VStack{
//                            Text("Hello")
//                        }
//                        .background(Color.white.opacity(0.1))
//                        .frame(width: 1, height: 250)
                        
                        VStack {
                            HStack {
                                Text("종료 시간")
                                    .bold()
                                .foregroundColor(.white)
                                
                                Spacer()
                            }
                            
                            HStack {
                                CustomHourPicker(selectedHour: $selectedEndHour)
                                    .frame(width: 120, height: 120)
                                
                                Spacer()
                            }
                        }
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 4, trailing: 16))
                    }
                    
                    
                    Divider()
                        .background(Color.white).opacity(0.2)
                        .padding(.leading)
                    
                    VStack {
                        HStack {
                            Text("요일")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading)
                                .padding(.top, 8)
                            
                            Spacer()
                        }
                        
                        SelectNotificationDay(selectedDays: $selectedWeekdays)
                            .padding(EdgeInsets(top: 4, leading: 6, bottom: 16, trailing: 0))
                    }
                }
                .background(Color.init(hue: 0, saturation: 0, brightness: 0.16))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
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
                            if selectedEndHour > selectedStartHour {
                
                                /// 선택된 스케줄을 파라미터로 전달하고 푸시 알림 요청
                                localNotificationManager.setLocalNotification(
                                    weekdays: selectedDaysInt,
                                    startHour: selectedStartHour,
                                    endHour: selectedEndHour,
                                    frequency: selectedFrequency
                                )
                                
                                localNotificationManager.cancelNotification()
                                
                                /// 변경된 데이터 UserDefaults에 저장
                                saveNotificationData()
                        
                                isSubmitted = true
                                
                            } else {
                                isInputCorrect = true
                            }
                        } label: {
                            Text("완료")
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}




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
