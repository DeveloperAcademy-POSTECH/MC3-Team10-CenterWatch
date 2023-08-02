//
//  NotificationSettingsCell.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/25.
//

import SwiftUI

// MARK: - Notification Interval (Enum)
enum TimeInterval: Int {
    case hour = 60
    case twoHour = 120
    case threeHour = 180
}

struct NotificationSettingsCell: View {
    
    /// 모달뷰 띄우기용
    @State private var showModal = false
    
    let notificationCycles: [TimeInterval] = [.hour, .twoHour, .threeHour]
    
    @Binding var selectedStartHour: Int
    @Binding var selectedEndHour: Int
    @Binding var selectedFrequency: TimeInterval
    @Binding var selectedWeekdays: [SelectedDay]
    @Binding var settings: Setting
    @State var textOpacity: Double = 1
    
    var selectedDaysInt: [Int] {
        var daysConvertedToInt: [Int] = []
        for selectedDay in settings.selectedDays {
            if selectedDay.selected {
                daysConvertedToInt.append((settings.selectedDays.firstIndex(of: selectedDay) ?? 0) + 1)
            }
        }
        return daysConvertedToInt
    }
    
    // @State var isIntervalCorrect: Bool = true
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("알림 주기")
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "Pretendard-Medium", size: 16)!))
                        .opacity(0.7)
                    
                    Text("\(selectedFrequency.rawValue / 60)시간")
                        .foregroundColor(.white)
                        .padding(.bottom, -1)
                        .padding(.top, -15)
                        .font(Font(UIFont(name: "Pretendard-Bold", size: 45)!))
                        .opacity(textOpacity)
                        .id("NotificationSettingsSelectedFrequencyTextView\(selectedFrequency.rawValue)")
                }
                
                Spacer()
                
                // MARK: - 알림 설정 버튼
                    Button {
                        self.showModal = true
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                        impactHeavy.impactOccurred()
                        
                    } label: {
                        Image(systemName: "alarm.fill")
                        Text("알림 설정")
                            .padding(4)
                    }
                    .font(Font(UIFont(name: "Pretendard-Bold", size: 16)!))
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(24)
                    .sheet(isPresented: self.$showModal) {
                        ModalView(selectedStartHour: $selectedStartHour,
                                  selectedEndHour: $selectedEndHour,
                                  selectedFrequency: $selectedFrequency,
                                  selectedWeekdays: $settings.selectedDays,
                                  settings: $settings,
                                  textOpacity: $textOpacity)
                    .preferredColorScheme(.dark)
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
                            .opacity(textOpacity)
                        
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
                            .opacity(textOpacity)
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
                            
                            Text("일").opacity(settings.selectedDays[0].selected ? 1 : 0.3)
                            Text("월").opacity(settings.selectedDays[1].selected ? 1 : 0.3)
                            Text("화").opacity(settings.selectedDays[2].selected ? 1 : 0.3)
                            Text("수").opacity(settings.selectedDays[3].selected ? 1 : 0.3)
                            Text("목").opacity(settings.selectedDays[4].selected ? 1 : 0.3)
                            Text("금").opacity(settings.selectedDays[5].selected ? 1 : 0.3)
                            Text("토").opacity(settings.selectedDays[6].selected ? 1 : 0.3)
                            
                        }
                        .opacity(textOpacity)
                        .foregroundColor(.white)
                        .font(Font(UIFont(name: "Pretendard-Bold", size: 45)!))
                    }
                }
                .padding([.leading, .trailing, .bottom])
            }
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
        .onTouchDownGesture {
            let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
            impactHeavy.impactOccurred()
        }
        
    }
}



extension View {
    
    func onTouchDownGesture(callback: @escaping () -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(callback: callback))
    }
}

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let callback: () -> Void
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(CGSize(width: self.tapped ? 0.95 : 1, height: self.tapped ? 0.95 : 1), anchor: .center)
            .animation(.easeOut(duration: 0.2), value: self.tapped)
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !self.tapped {
                        self.tapped = true
                        self.callback()
                    }
                }
                .onEnded { _ in
                    self.tapped = false
                })
    }
}

