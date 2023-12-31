//
//  DayOffToggleView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/08/01.
//

import SwiftUI

class ToggleStateModel: ObservableObject {
    @Published var toggleIsOn: Bool = UserDefaults.standard.bool(forKey: "toggleIsOn") {
        didSet {
            UserDefaults.standard.set(self.toggleIsOn, forKey: "toggleIsOn")
            if toggleIsOn {
                self.animationPaused = true
                grayscaleValue = 1.0
            } else {
                self.animationPaused = false
                grayscaleValue = 0.0
            }
        }
    }
    /// 하루만 알림 끄기
    @Published var animationPaused: Bool = false
    @Published var grayscaleValue: Double = 0.0
    
    init() {
        self.animationPaused = animationPaused
        self.grayscaleValue = grayscaleValue
    }
}

struct DailyNotiToggleRow: View {
    
    @Binding var toggleIsOn: Bool
    
    var body: some View {
        HStack(spacing: 10){
            Toggle(isOn: $toggleIsOn, label: {
                Label(String(localized: "Turn off notifications for a day"), systemImage: "powersleep")
                    .font(Font.custom("Pretendard-Bold", size: 16))
                    .foregroundColor(.white)
                    .opacity(0.7)
                
            }).tint(.blue)
        }
        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 24))
    }
}

struct DayOffToggleView_Previews: PreviewProvider {
    static var previews: some View {
        DailyNotiToggleRow(toggleIsOn: .constant(false))
            .preferredColorScheme(.dark)
    }
}
