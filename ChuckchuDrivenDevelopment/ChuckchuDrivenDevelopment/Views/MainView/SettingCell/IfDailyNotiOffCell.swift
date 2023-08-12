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
            
            FontView("현재 알림이 꺼져 있어요.\n다음 날, 핀이 다시 돌아올거에요.", .pretendardBold, 19, .white, 1)
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
