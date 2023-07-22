//
//  SelectNotificationDay.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/17.
//

import SwiftUI

struct SelectNotificationDay: View {
    
    @Binding var selectedDays: [SelectedDay]

    var body: some View {
        HStack {
            Group {
                ForEach(selectedDays.indices, id: \.self) { i in
                    Group {
                        Button {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedDays[i].selected.toggle()
                            }
                        } label: {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(selectedDays[i].selected ? .blue : Color.white)
                                .overlay() {
                                    Text(selectedDays[i].day).font(.callout)
                                        .foregroundColor(selectedDays[i].selected ? Color.white : Color.black)
                                        .fontWeight(selectedDays[i].selected ? .bold : .regular)
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                }
            }
        }
        .frame(height: 40)
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
    }
}

struct SelectNotificationDay_Previews: PreviewProvider {
    @State static var previewData: [SelectedDay] = [
        SelectedDay(day: "월", selected: true),
        SelectedDay(day: "화", selected: true),
        SelectedDay(day: "수", selected: true),
        SelectedDay(day: "목", selected: true),
        SelectedDay(day: "금", selected: true),
        SelectedDay(day: "토", selected: false),
        SelectedDay(day: "일", selected: false)
    ]
    
    static var previews: some View {
        SelectNotificationDay(selectedDays: $previewData)
    }
}
