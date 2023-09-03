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
                FontView(String(localized: "Start Time"), .pretendardBold, 18, .white, 1)
                    .padding(.leading, 10)
                
                HStack{
                    Picker("", selection: $selectedStartHour) {
                        //시작시간이 23까지만 표시되도록
                        ForEach(0..<24, id: \.self) { hour in
                            Text(String(format: "%02d:00", hour))
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 130, height: 120)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 10))
            
            VStack(alignment: .leading) {
                FontView(String(localized: "End Time"), .pretendardBold, 18, .white, 1)
                    .padding(.leading, 10)
                
                HStack{
                    Picker("", selection: $selectedEndHour) {
                        ForEach(selectedStartHour + 1...min(selectedStartHour + 10, 24), id: \.self) { hour in
                            Text(String(format: "%02d:00", hour))
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 130, height: 120)
                    Spacer()
                }
            }
        }
        .onChange(of: selectedStartHour) { newValue in
            //종료시간이 시작시간에 밀려도 종료시간이 설정되게
            selectedEndHour = max(selectedStartHour + 1,
                                  min(selectedStartHour + 10, selectedEndHour)
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
