//
//  OnboardingView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/30.
//

import SwiftUI

struct OnboardingView1: View {
    
    @State private var splashOn: Bool = false
    @State private var animationPaused = false // Set default value here
    @State private var grayscale = 0.0 // Set default value here
    
    let optionalFontBold: UIFont? = UIFont(name: "Pretendard-Bold", size: 38)
    let optionalFontMedium: UIFont? = UIFont(name: "Pretendard-Medium", size: 19)
    
    var body: some View {
        VStack {
            
            Spacer()
            
            CharacterAnimation(animationPaused: $animationPaused, grayscale: $grayscale)
            
            Spacer()
            
            VStack {
                
                Text("""
핀과 함께하는
바른 자세 만들기
""")
                if let unwrappedFont = optionalFontBold {
                    Text("""
    핀과 함께하는
    바른 자세 만들기
    """)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(Font(unwrappedFont))
                        .padding(.bottom, 24)
                        .padding(.top, 50)
                }
               
                Text("""
내가 원하는 주기에 알림을 받고,
즉각적인 바른자세를 쉽게 만드세요.
""")
                if let unwrappedFont = optionalFontMedium {
                    Text("""
    내가 원하는 주기에 알림을 받고,
    즉각적인 바른자세를 쉽게 만드세요.
    """)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white).opacity(0.7)
                    .font(Font(unwrappedFont))
                    .lineSpacing(4)
                }
                
                Spacer()
                
                NavigationLink {
                    OnboardingView2()
                } label: {
                    Text("시작하기")
                    if let unwrappedFont = optionalFontMedium {
                        Text("시작하기")
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .font(Font(unwrappedFont))
                    }
                }
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding()
                .padding(.bottom, 40)
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
