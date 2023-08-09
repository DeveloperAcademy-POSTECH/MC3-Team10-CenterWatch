//
//  DayOffToggleView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/08/01.
//

import SwiftUI



struct DayOffToggleView: View {
    
    @Binding var toggleIsOn: Bool

    var body: some View {
        HStack(spacing: 10){
            Toggle(isOn: $toggleIsOn, label: {
                Label("하루만 알림 끄기", systemImage: "powersleep")
                    .foregroundColor(.white)
                    .opacity(0.7)
                
            }).tint(.blue)
        }
        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 24))
    }
}

struct DayOffToggleView_Previews: PreviewProvider {
    static var previews: some View {
        DayOffToggleView(toggleIsOn: .constant(false))
            .preferredColorScheme(.dark)
    }
}
