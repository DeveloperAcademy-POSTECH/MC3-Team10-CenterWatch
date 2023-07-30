//
//  OnboardingView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/30.
//

import SwiftUI

struct OnboardingView1: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            CharacterAnimation()
            
            Spacer()
            
            VStack {
                Text("""
핀과 함께하는
바른 자세 만들기
""")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(Font(UIFont(name: "Pretendard-Bold", size: 38)!))
                    .padding(.bottom, 24)
                    .padding(.top, 50)
                
                Text("""
내가 원하는 주기에 알림을 받고,
즉각적인 바른자세를 쉽게 만드세요.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.white).opacity(0.7)
                .font(Font(UIFont(name: "Pretendard-Medium", size: 19)!))
                .lineSpacing(4)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("시작하기")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .font(Font(UIFont(name: "Pretendard-Medium", size: 19)!))
                }
                .buttonStyle(.borderedProminent)
                .padding()

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.08))
    }
}

struct OnboardingView1_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView1()
    }
}
