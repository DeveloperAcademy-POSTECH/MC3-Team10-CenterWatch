//
//  TimePickerView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/07/31.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var selectedStartHour: Int
    @Binding var selectedEndHour: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                FontView("시작 시간", 18, .white)
                    .padding(.leading, 10)
                HStack{
                    WheelPickerView(selectedHour: $selectedStartHour)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            VStack(alignment: .leading) {
                FontView("종료 시간", 18, .white)
                    .padding(.leading, 10)
                HStack{
                    WheelPickerView(selectedHour: $selectedEndHour, minHour: selectedStartHour + 1, maxHour: selectedStartHour + 7) 
                    Spacer()
                }
            }
        }
        .onChange(of: selectedStartHour) { newValue in
            selectedEndHour = max(selectedStartHour + 1, min(selectedStartHour + 6, selectedEndHour))
        }
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(selectedStartHour: .constant(0), selectedEndHour: .constant(0))
            .preferredColorScheme(.dark)
    }
}
