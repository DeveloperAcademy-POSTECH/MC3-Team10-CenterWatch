//
//  TimePickerView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/07/31.
//

import SwiftUI

struct TimePickerRow: View {
    @Binding var selectedStartHour: Int
    @Binding var selectedEndHour: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                FontView("시작 시간", .pretendardBold, 18, .white, 1)
                    .padding(.leading, 10)
                
                HStack{
                    WheelPickerView(selectedHour: $selectedStartHour)
                        Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 10))
            
            VStack(alignment: .leading) {
                FontView("종료 시간", .pretendardBold, 18, .white, 1)
                    .padding(.leading, 10)
                
                HStack{
                    
                    WheelPickerView(selectedHour: $selectedEndHour, minHour: selectedStartHour + 1, maxHour: selectedStartHour + 10)
                        Spacer()
                }
            }
        }
        .onChange(of: selectedStartHour) { newValue in
            selectedEndHour = max(selectedStartHour + 1,
                                  min(selectedStartHour + 6, selectedEndHour)
            )
        }
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerRow(selectedStartHour: .constant(0), selectedEndHour: .constant(0))
            .preferredColorScheme(.dark)
    }
}
