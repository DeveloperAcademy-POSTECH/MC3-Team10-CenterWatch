//
//  OnboardingView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/30.
//

import SwiftUI

struct OnBoardingView1: View {
    
    @State private var splashOn: Bool = false
    @State private var animationPaused = false
    @State private var grayscale = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            
            CharacterAnimation(animationPaused: $animationPaused, grayscale: $grayscale)
                
            OnboardingText(title: String(localized: "Creating Good Posture with Pin"), subTitle: String(localized: "At your preferred intervals, receive notifications and easily achieve proper posture instantly."))
            
            nextButton(label: String(localized: "Getting started"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hue: 0, saturation: 0, brightness: 0.08))
    }
    
    @ViewBuilder
    private func OnboardingText(title: String, subTitle: String) -> some View {
        VStack(spacing: 20) {
            FontView(title, .pretendardBold, 38, .white, 1)
            FontView(subTitle, .pretendardMedium, 19, .white, 0.7)
        }
        .multilineTextAlignment(.center)
        .lineSpacing(4)
        .padding()
    }
    
    @ViewBuilder
    private func nextButton(label: String) -> some View {
        NavigationLink {
            OnBoardingView2()
        } label: {
            FontView(label, .pretendardBold, 19, .white, 1)
                .frame(maxWidth: .infinity, maxHeight: 60)
        }
        .background(Color.accentColor)
        .cornerRadius(15)
        .padding()
        .padding(.bottom, -4)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded() {_ in
                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                    impactHeavy.impactOccurred()
                }
        )
        .onTouchDownGesture(shrinkRate: 0.95) {
            let impactHeavy = UIImpactFeedbackGenerator(style: .soft)
            impactHeavy.impactOccurred()
        }
    }
}

struct OnBoardingView1_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView1()
    }
}
