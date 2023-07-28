//
//  NotificationSettingsCell.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/25.
//

import SwiftUI

struct NotificationSettingsCell: View {
    
    /// 모달뷰 띄우기용
    @State private var showModal = false
    
    let notificationCycles: [MinuteInterval] = [.tenMinutes, .quarterHour, .halfHour, .hour]
    
    @Binding var selectedStartHour: Int
    @Binding var selectedEndHour: Int
    @Binding var selectedFrequency: MinuteInterval
    @Binding var selectedWeekdays: [SelectedDay]
    @Binding var settings: Setting
  
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
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("알림 주기")
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "Pretendard-Medium", size: 16)!))
                        .opacity(0.7)
                    
                    Text("\(selectedFrequency.rawValue)" + "분")
                        .foregroundColor(.white)
                        .padding(.bottom, -1)
                        .padding(.top, -15)
                        .font(Font(UIFont(name: "Pretendard-Bold", size: 45)!))
                    
                    
                }
                
                Spacer()
                
                // MARK: - 알림 설정 버튼
                VStack {
                    Button {
                        
                        self.showModal = true
                        
                    } label: {
                        HStack {
                            Image(systemName: "alarm.fill")
                            
                            Text("알림 설정")
                                .font(Font(UIFont(name: "Pretendard-Bold", size: 16)!))
                        }
                        .padding(4)
                    }
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(24)
                    // FIXME: toast message 등으로 UI 변경
                    //            .alert("'종료 시간'을 '시작 시간'보다 \n늦은 시간대로 맞춰주세요 ⏰", isPresented: $isInputCorrect) {
                    //                Button("확인", role: .cancel) { }
                    //            }
                    //            .alert("알림이 설정되었어요! 🤩", isPresented: $isSubmitted) {
                    //                Button("확인", role: .cancel) { }
                    //            }
                    .sheet(isPresented: self.$showModal) {
                        ModalView(selectedStartHour: $selectedStartHour,
                                  selectedEndHour: $selectedEndHour,
                                  selectedFrequency: $selectedFrequency,
                                  selectedWeekdays: $settings.selectedDays,
                                  settings: $settings)
                        .preferredColorScheme(.dark)
                    }
                }
            }
            .padding([.top, .leading, .trailing])
            
            Divider()
                .padding(.leading)
                .padding(.bottom, 5)
            
            VStack {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("시작 시간")
                            .foregroundColor(.white)
                            .opacity(0.7)
                            .font(Font(UIFont(name: "Pretendard-Medium", size: 16)!))
                        
                        Text(String(format: "%02d", selectedStartHour) + ":00")
                            .font(Font(UIFont(name: "Pretendard-Bold", size: 45)!))
                            .foregroundColor(.white)
                            .padding(.bottom, -1)
                            .padding(.top, -15)
                        
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("종료 시간")
                            .font(Font(UIFont(name: "Pretendard-Medium", size: 16)!))
                            .foregroundColor(.white)
                            .opacity(0.7)
                        
                        Text(String(format: "%02d", selectedEndHour) + ":00")
                            .foregroundColor(.white)
                            .font(Font(UIFont(name: "Pretendard-Bold", size: 45)!))
                            .padding(.bottom, -1)
                            .padding(.top, -15)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                }
                
                Divider()
                    .padding(.leading)
                    .padding(.bottom, 5)
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("요일")
                            .font(Font(UIFont(name: "Pretendard-Medium", size: 16)!))
                            .foregroundColor(.white)
                            .opacity(0.7)
                        
                        HStack {
                            if(!settings.selectedDays[0].selected) {
                                Text("일").opacity(0.3)
                            } else {
                                Text("일")
                            }
                            
                            
                            
                            Spacer()
                            
                            Group {
                                if(!settings.selectedDays[1].selected) {
                                    Text("월").opacity(0.3)
                                } else {
                                    Text("월")
                                }
                                Spacer()
                                if(!settings.selectedDays[2].selected) {
                                    Text("화").opacity(0.3)
                                } else {
                                    Text("화")
                                }
                                Spacer()
                                if(!settings.selectedDays[3].selected) {
                                    Text("수").opacity(0.3)
                                } else {
                                    Text("수")
                                }
                                Spacer()
                                if(!settings.selectedDays[4].selected) {
                                    Text("목").opacity(0.3)
                                } else {
                                    Text("목")
                                }
                                Spacer()
                                if(!settings.selectedDays[5].selected) {
                                    Text("금").opacity(0.3)
                                } else {
                                    Text("금")
                                }
                            }
                            
                            Spacer()
                            if(!settings.selectedDays[6].selected) {
                                Text("토").opacity(0.3)
                            } else {
                                Text("토")
                            }
                            
                        }
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "Pretendard-Bold", size: 45)!))
                    }
                }
                .padding([.leading, .trailing, .bottom])
            }
        }
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.12))
        .cornerRadius(20)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .onTapGesture {
            self.showModal = true
        }
    }
}



// struct NotificationSettingsCell_Previews: PreviewProvider {
//     @State static var previewData: [SelectedDay] = [
//         SelectedDay(day: "월", selected: true),
//         SelectedDay(day: "화", selected: true),
//         SelectedDay(day: "수", selected: true),
//         SelectedDay(day: "목", selected: true),
//         SelectedDay(day: "금", selected: true),
//         SelectedDay(day: "토", selected: false),
//         SelectedDay(day: "일", selected: true)
//     ]
//
//     static var previews: some View {
//         NotificationSettingsCell(selectedStartHour: .constant(8), selectedEndHour: .constant(18), selectedFrequency: .constant(.tenMinutes), selectedWeekdays: $previewData, settings: <#T##Binding<Setting>#>)
//     }
// }

