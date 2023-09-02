//
//  FrequencySettingRow.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/08/12.
//

import SwiftUI

struct FrequencySettingRow: View {
    
    @Binding var with: NotiInterval
    var label: String
    
    private let notificationCycles: [NotiInterval] = [.hour, .twoHour, .threeHour]
    
    var body: some View {
        HStack {
            FontView(label, .pretendardBold, 18, .white, 1)
                .padding(.leading, 20)
                .frame(height: 60)
            
            Spacer()
            
            Picker(label, selection: $with) {
                ForEach(notificationCycles, id: \.self) { interval in
                    FontView("\(interval.rawValue / 60)"+String(localized: "Hour"), .pretendardBold, 18, .white, 1)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.trailing, 10)
            .onTapGesture {
                let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
                impactHeavy.impactOccurred()
            }
            
        }
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.16))
        .cornerRadius(20)
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
    }
}

struct FrequencySettingRow_Previews: PreviewProvider {
    static var previews: some View {
        FrequencySettingRow(with: .constant(.hour), label: "알림 설정")
    }
}
