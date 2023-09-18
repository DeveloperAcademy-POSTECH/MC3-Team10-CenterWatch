//
//  NotificationSettingsCell.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/25.
//

import SwiftUI

struct SettingInfomationCell: View {
    @State private var showModal = false
    @State private var textOpacity: Double = 1
    
    @Binding var settings: Setting
    
    var body: some View {
        VStack(alignment: .leading) {
            
            /// 1층: 알림 주기와 알림 설정 버튼
            HStack(alignment: .top) {
                
                selectedFrequencyViewer(frequencyWith: settings.selectedFrequency)
                
                    Spacer()

                settingModalButton(name: String(localized: "Notification Settings"))
                
            }
            .padding([.top, .leading, .trailing])
            
                Divider().padding(.leading).padding(.bottom, 5)
                
            /// 2층: 알림 시작 시간과 종료 시간
            selectedHourViewer(startWith: settings.selectedStartHour, endWith: settings.selectedEndHour)
            
                Divider().padding(.leading).padding(.bottom, 5)
            
            ///3층: 선택된 요일
            selectedDayViewer(dayWith: settings.selectedDays)

        }
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.12))
        .cornerRadius(20)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded() {_ in
                    self.showModal = true
                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                    impactHeavy.impactOccurred()
                }
        )
        .onTouchDownGesture(shrinkRate: 0.95) {
            let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
            impactHeavy.impactOccurred()
        }
    }
    
    // MARK: 알림 주기를 보여줍니다.
    @ViewBuilder
    private func selectedFrequencyViewer(frequencyWith: NotiInterval) -> some View {
        VStack(alignment: .leading) {
            FontView(String(localized: "Notification Interval"), .pretendardMedium, 16, .white, 0.7)
            
            FontView("\(frequencyWith.rawValue / 60)" + String(localized: "Hour"), .pretendardBold, 45, .white, Float(textOpacity))
                .padding(.bottom, -1)
                .padding(.top, -15)
                .id("NotificationSettingsSelectedFrequencyTextView\(frequencyWith.rawValue)")
        }
    }
    
    // MARK: 모달을 열 수 있음을 직관적으로 전달하는 버튼입니다.
    @ViewBuilder
    private func settingModalButton(name: String) -> some View {
        Button {
            self.showModal = true
            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
            impactHeavy.impactOccurred()
            
        } label: {
            Image(systemName: "alarm.fill").padding(.leading, 2)
            FontView(name, .pretendardBold, 16, .white, 1).padding(4)
        }
        .buttonStyle(.borderedProminent)
        .cornerRadius(20)
        .sheet(isPresented: self.$showModal) {
            ModalView(settings: $settings, textOpacity: $textOpacity)
        }
    }

    // MARK: 선택된 시작 시간, 종료 시간을 보여줍니다.
    @ViewBuilder
    private func selectedHourViewer(startWith: Int, endWith: Int) -> some View {
        HStack {
            VStack(alignment: .leading) {
                FontView(String(localized: "Start Time"), .pretendardMedium, 16, .white, 0.7)
                
                FontView(String(format: "%02d", startWith) + ":00", .pretendardBold, 45, .white, Float(textOpacity))
                    .padding(.bottom, -1).padding(.top, -15)
                
            }
            .padding(.leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                FontView(String(localized: "End Time"), .pretendardMedium, 16, .white, 0.7)
                
                FontView(String(format: "%02d", endWith) + ":00", .pretendardBold, 45, .white, Float(textOpacity))
                    .padding(.bottom, -1).padding(.top, -15)
                    
            }
            .padding(.leading)
            
            Spacer()
            
        }
    }

    // MARK: 선택된 요일을 보여줍니다.
    @ViewBuilder
    private func selectedDayViewer(dayWith: [SelectedDay]) -> some View {
        let monLetter = String(String(localized: "Mon").first ?? Character(""))
        let tueLetter = String(String(localized: "Tue").first ?? Character(""))
        let wedLetter = String(String(localized: "Wed").first ?? Character(""))
        let thuLetter = String(String(localized: "Thu").first ?? Character(""))
        let friLetter = String(String(localized: "Fri").first ?? Character(""))
        
        VStack {
            VStack(alignment: .leading) {
                FontView(String(localized: "Day"), .pretendardMedium, 16, .white, 0.7)
                
                HStack(spacing: 16) {
                    Text("\(monLetter)").opacity(dayWith[1].selected ? 1 : 0.3)
                    Text("\(tueLetter)").opacity(dayWith[2].selected ? 1 : 0.3)
                    Text("\(wedLetter)").opacity(dayWith[3].selected ? 1 : 0.3)
                    Text("\(thuLetter)").opacity(dayWith[4].selected ? 1 : 0.3)
                    Text("\(friLetter)").opacity(dayWith[5].selected ? 1 : 0.3)
                }
                .opacity(textOpacity)
                .foregroundColor(.white)
                .font(Font.custom("Pretendard-Bold", size: 45))
            }
        }
        .padding([.leading, .trailing, .bottom])
    }
}
