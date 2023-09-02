//
//  OnBoardingView2.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/30.
//

import SwiftUI

struct OnBoardingView2: View {
    
    @ObservedObject var localNotificationManager: LocalNotificationManager = LocalNotificationManager()
    
    var body: some View {
        VStack {
            iconAndText(textLabel: String(localized: "If you allow notifications, you can receive heartfelt messages from Fynn."))
                Spacer()
            
            settingButton(label: String(localized: "Go to notification settings"))
        }
        .background() {
            onboardingBackground(label: "onBoarding")
        }
    }
    
    @ViewBuilder
    private func iconAndText(textLabel: String) -> some View {
        Image("icon-notification-mono")
            .background() {
                Circle()
                    .frame(width: 84, height: 84)
                    .opacity(0.7)
                    .foregroundColor(.black)
            }
            .padding(.bottom, 30).padding(.top, 80)
        
        FontView(textLabel, .pretendardBold, 20, .white, 1)
            .multilineTextAlignment(.center)
            .lineSpacing(6)
            .frame(maxWidth: 300)
    }
    
    @ViewBuilder
    private func settingButton(label: String) -> some View {
        NavigationLink {
            MainView()
        } label: {
            FontView(label, .pretendardBold, 19, .white, 1)
                .frame(maxWidth: .infinity, maxHeight: 60)
        }
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(15)
        .padding(.horizontal)
        .simultaneousGesture(TapGesture().onEnded {
            /// 시스템 알림 허용 요청
            localNotificationManager.requestNotificationPermission()
        })
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
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private func onboardingBackground(label: String) -> some View {
        VStack {
            Image(label)
                .resizable()
                .scaledToFill()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}


struct OnBoardingView2_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView2()
    }
}
