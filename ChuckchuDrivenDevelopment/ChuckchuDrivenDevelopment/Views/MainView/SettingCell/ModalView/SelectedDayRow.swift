//
//  SelectNotificationDay.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/17.
//

import SwiftUI

struct SelectedDayRow: View {
    
    @Binding var selectedDays: [SelectedDay]
    
    var body: some View {
        HStack(alignment: .center) {
            Group {
                ForEach(selectedDays.indices, id: \.self) { i in
                    if i != 0, i != 6 {
                        Group {
                            Button {
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    selectedDays[i].selected.toggle()
                                }
                            } label: {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(selectedDays[i].selected ? Color.blue : Color.white.opacity(0.1))
                                    .overlay() {
                                        FontView(selectedDays[i].day, .pretendardBold, 18, .white, 1)
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .onTouchDownGesture(shrinkRate: 0.9) {
                                let impactHeavy = UIImpactFeedbackGenerator(style: .light)
                                impactHeavy.impactOccurred()
                            }
                            if(i != 5) {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 10)
        }
        .frame(height: 40)
    }
}

struct SelectNotificationDay_Previews: PreviewProvider {
    @State static var previewData: [SelectedDay] = [
        SelectedDay(day: "월", selected: true),
        SelectedDay(day: "화", selected: true),
        SelectedDay(day: "수", selected: true),
        SelectedDay(day: "목", selected: true),
        SelectedDay(day: "금", selected: true)
    ]
    
    static var previews: some View {
        SelectedDayRow(selectedDays: $previewData)
    }
}
