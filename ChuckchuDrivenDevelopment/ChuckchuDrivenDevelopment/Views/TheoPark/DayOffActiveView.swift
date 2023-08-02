//
//  DayOffActiveView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/08/01.
//

import SwiftUI

struct DayOffActiveView: View {
    var body: some View {
        VStack(spacing: 25) {
            Image("Icon_DayOffActive")
            Text("현재 알림이 꺼져 있어요.\n다음 날, 핀이 다시 돌아올거에요.")
                .multilineTextAlignment(.center)
                .font(Font.custom("Pretendard-Bold", size: 19))
//                .font(Font(UIFont(name: "Pretendard-Bold", size: 19)!))
                .lineSpacing(8)
                .padding(.bottom)
        }
    }
}

struct DayOffActiveView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DayOffActiveView()
                .preferredColorScheme(.dark)
        }
    }
}
