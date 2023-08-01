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
                Text("시작 시간")
                        .font(Font.custom("Pretendard-Bold", size: 18))
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                HStack{
                    Picker("", selection: $selectedStartHour) {
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
            .padding()

            VStack(alignment: .leading) {
                Text("종료 시간")
                    .font(Font.custom("Pretendard-Bold", size: 18))
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                
                HStack{
                    Picker("", selection: $selectedEndHour) {
                        ForEach(selectedStartHour + 1...min(selectedStartHour + 6, 24), id: \.self) { hour in
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
