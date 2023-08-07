////
////  BottomView.swift
////  ChuckchuDrivenDevelopment
////
////  Created by been on 2023/08/02.
////
//
//import SwiftUI
//
//struct BottomView: View {
//    
//    @ObservedObject var manager = MotionManager()
//    
//    @Binding var selectedStartHour: Int
//    @Binding var selectedEndHour: Int
//    @Binding var selectedFrequency: TimeInterval
//    @Binding var selectedWeekdays: [SelectedDay]
//    @Binding var settings: Setting
//    @Binding var textOpacity: Double
//    
//    @Binding var animationPaused : Bool
//    @Binding var grayscaleValue: Double
//    @Binding var toggleIsOn: Bool
//    var cellOpacity: Double {
//        toggleIsOn ? 0 : 1
//    }
//    
//    var body: some View {
//        
//
//        
//        ZStack {
//            NotificationSettingsCell(selectedStartHour: $selectedStartHour, selectedEndHour: $selectedEndHour, selectedFrequency: $selectedFrequency, selectedWeekdays: $settings.selectedDays, settings: $settings)
//                .opacity(cellOpacity)
//                .cornerRadius(20)
//                .shadow(radius: 6)
//                .modifier(ParallaxMotionModifier(manager: manager, magnitude3d: 20, magnitude2d: 15))
//            
//            DayOffActiveView()
//                .opacity(1-cellOpacity)
//                .onChange(of: toggleIsOn) { newValue in
//                    // Update animationPaused and grayscaleValue based on toggleIsOn
//                    if newValue {
//                        animationPaused = true
//                        grayscaleValue = 1.0
//                    } else {
//                        animationPaused = false
//                        grayscaleValue = 0.0
//                    }
//                }
//            
//        }
//        .background(Color.init(hue: 0, saturation: 0, brightness: 0.12))
//        .cornerRadius(20)
//        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
//        .shadow(radius: 6)
//        .modifier(ParallaxMotionModifier(manager: manager, magnitude3d: 20, magnitude2d: 15))
//    }
//}
//
//
//
