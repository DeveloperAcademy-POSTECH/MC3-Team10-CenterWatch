//
//  WheelPickerView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/08/04.
//

import SwiftUI

struct WheelPickerView: View {
    
    @Binding var selectedHour: Int
    
    let minHour: Int
    let maxHour: Int
    
    init(selectedHour: Binding<Int>, minHour: Int = 0, maxHour: Int = 24) {
        self._selectedHour = selectedHour
        self.minHour = validateHour(hour: minHour)
        self.maxHour = validateHour(hour: maxHour)
        
        func validateHour(hour: Int) -> Int {
            if (hour < 0) {
                return 0
            }
            
            if (hour > 24) {
                return 24
            }
            
            return hour
        }
    }
    
    var body: some View {
        
        Picker("", selection: $selectedHour) {
            ForEach(minHour...maxHour, id: \.self) { hour in
                Text(String(format: "%02d:00", hour))
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 130, height: 120)
    }
}
