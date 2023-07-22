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
                    .font(.system(size: 18))
            }
        }
        .pickerStyle(WheelPickerStyle())
    }
}

//struct CustomHourPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomHourPicker()
//    }
//}
