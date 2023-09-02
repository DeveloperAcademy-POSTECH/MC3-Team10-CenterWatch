//
//  DayOffActiveView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/08/01.
//

import SwiftUI

struct IfDailyNotiOffCell: View {
    var body: some View {
        VStack(spacing: 25) {
            Image("Icon_DayOffActive")
            
            FontView(String(localized: "The notifications are currently turned off. Fynn will be back tomorrow."), .pretendardBold, 19, .white, 1)
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .lineSpacing(8)
        }
    }
}

struct DayOffActiveView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IfDailyNotiOffCell()
                .preferredColorScheme(.dark)
        }
    }
}
