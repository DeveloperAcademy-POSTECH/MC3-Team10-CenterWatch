//
//  MainView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/25.
//

import SwiftUI

struct SelectedDay {
    let day: String
    var selected: Bool
}

struct Setting {
    var selectedDays: [SelectedDay] = [
        SelectedDay(day: "월", selected: true),
        SelectedDay(day: "화", selected: true),
        SelectedDay(day: "수", selected: true),
        SelectedDay(day: "목", selected: true),
        SelectedDay(day: "금", selected: true),
        SelectedDay(day: "토", selected: false),
        SelectedDay(day: "일", selected: false)
    ]
    
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
}

struct MainView: View {
    
    @State var settings = Setting()
    let notificationCycles: [String] = ["10분", "15분", "30분", "1시간"]
    
    var body: some View {
        VStack {
            Spacer()
            
            CharacterAnimation()
                .shadow(color: .blue.opacity(0.2), radius: 40)
            
            Spacer()
            
            VStack {
                HStack {
                    Text("알림 주기")
                        .bold()
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .padding(.leading, 18)
                    
                    Spacer()
                    
                    Picker("알림 주기", selection: $settings.notificationCycle) {
                        ForEach(notificationCycles, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.trailing, 10)
                }
                .background(Color.init(hue: 0, saturation: 0, brightness: 0.12))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                
                VStack {
                    HStack {
                        Text("시작 시간")
                            .bold()
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        DatePicker("", selection: $settings.startTime, displayedComponents: [.hourAndMinute])
                            .foregroundColor(.white)
                    }
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 4, trailing: 16))
                    
                    Divider()
                        .background(Color.white).opacity(0.1)
                        .padding(.leading)
                    
                    HStack {
                        Text("종료 시간")
                            .bold()
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        DatePicker("", selection: $settings.endTime, displayedComponents: [.hourAndMinute])
                            .foregroundColor(.white)
                    }
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    
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
                        
                        SelectNotificationDay(selectedDays: $settings.selectedDays)
                            .padding(EdgeInsets(top: 4, leading: 6, bottom: 16, trailing: 0))
                    }
                }
                .background(Color.init(hue: 0, saturation: 0, brightness: 0.12))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.08))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
