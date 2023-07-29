//
//  NotificationSettingsCell.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/25.
//

import SwiftUI

struct NotificationSettingsCell: View {
    
    let notificationCycles: [MinuteInterval] = [.halfHour, .hour]
    
    @Binding var selectedStartHour: Int
    @Binding var selectedEndHour: Int
    @Binding var selectedFrequency: MinuteInterval
    @Binding var selectedWeekdays: [SelectedDay]
    
    var body: some View {
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
                .frame(height: 60)
                .padding(.trailing, 8)
            }
            .background(Color.init(hue: 0, saturation: 0, brightness: 0.12))
            .cornerRadius(20)
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            
            
            VStack {
                
                HStack {
                    Text("시작 시간")
                    Spacer()
                    CustomHourPicker(selectedHour: $selectedStartHour)
                         .frame(width: 90, height: 60)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, -10)
                
                Divider()
                    .background(Color.white).opacity(0.1)
                    .padding(.leading)
                    .padding(.bottom, -10)
                
                HStack {
                    Text("종료 시간")
                    Spacer()
                    CustomHourPicker(selectedHour: $selectedEndHour)
                        .frame(width: 90, height: 60)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, -10)
                
                Divider()
                    .background(Color.white).opacity(0.1)
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
            .background(Color.init(hue: 0, saturation: 0, brightness: 0.12))
            .cornerRadius(20)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
        }
    }
}




/*
 struct NotificationSettingsCell_Previews: PreviewProvider {
     static var previews: some View {
         NotificationSettingsCell()
     }
 }
 */

