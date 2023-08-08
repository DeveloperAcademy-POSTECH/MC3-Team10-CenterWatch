//
//  OnBoardingView2.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/30.
//

import SwiftUI

struct OnBoardingView2: View {
    var body: some View {
        ZStack {
            VStack {
                Image("onBoarding")
                    .resizable()
                    .scaledToFill()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            
            VStack {
                
                Image("icon-notification-mono")
                    .background() {
                        Circle()
                            .opacity(0.7)
                            .frame(width: 84, height: 84)
                    }
                    .padding(.top, 100)
                    .padding(.bottom, 30)
                
                Text("""
알림을 허용하면, 핀의 진심이 담긴 메세지를 받을 수 있어요.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(Font(UIFont(name: "Pretendard-Bold", size: 20)!))
                .lineSpacing(6)
                .frame(maxWidth: 300)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("알림 설정")
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .font(Font(UIFont(name: "Pretendard-Medium", size: 19)!))
                }
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding()
                .padding(.bottom, 34)
            }
            
        }
    }
}


struct OnBoardingView2_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView2()
    }
}
