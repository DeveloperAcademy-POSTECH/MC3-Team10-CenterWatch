//
//  CustomHourPicker.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/23.
//

import SwiftUI

struct CustomHourPicker: View {
    @Binding var selectedHour: Int

    var body: some View {
        Picker("", selection: $selectedHour) {
            ForEach(0..<24) { hour in
                Text("\(hour):00").tag(hour)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor) // FIXME: 추후에 accentColor로 색상 변경
            }
        }
        .padding(.trailing, -8)
        .padding(.leading, -8)
        .pickerStyle(WheelPickerStyle())
    }
}
