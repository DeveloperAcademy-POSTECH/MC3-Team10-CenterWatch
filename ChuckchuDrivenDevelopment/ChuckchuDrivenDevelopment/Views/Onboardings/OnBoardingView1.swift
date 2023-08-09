//
//  OnboardingView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/30.
//

import SwiftUI

struct OnBoardingView1: View {
    
    @State private var splashOn: Bool = false
    @State private var animationPaused = false // Set default value here
    @State private var grayscale = 0.0 // Set default value here
    
    var body: some View {
        VStack(spacing: 20) {
            
            
            CharacterAnimation(animationPaused: $animationPaused, grayscale: $grayscale)
            //                .background(.red)
                .padding()
            //            Spacer()
            VStack(spacing: 20) {
                Text("""
핀과 함께하는
바른 자세 만들기
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(Font(UIFont(name: "Pretendard-Bold", size: 38)!))
                .lineSpacing(4)
                //                    .background(.blue)
                
                Text("""
내가 원하는 주기에 알림을 받고,
즉각적인 바른자세를 쉽게 만드세요.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.white).opacity(0.7)
                .font(Font(UIFont(name: "Pretendard-Medium", size: 19)!))
                .lineSpacing(4)
                
            }
            .padding()
            .padding()
            VStack {
                NavigationLink {
                    OnBoardingView2()
                } label: {
                    Text("시작하기")
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .font(Font(UIFont(name: "Pretendard-Medium", size: 19)!))
                }
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding()
                
                .padding(.bottom, -4)
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.08))
    }
}

struct OnBoardingView1_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView1()
    }
}
