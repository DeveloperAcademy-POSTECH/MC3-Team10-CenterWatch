//
//  OnBoardingView2.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/30.
//

import SwiftUI

struct OnboardingView2: View {
    @ObservedObject var localNotificationManager: LocalNotificationManager = LocalNotificationManager()
    
    let optionalFontBold: UIFont? = UIFont(name: "Pretendard-Bold", size: 21)
    let optionalFontMedium: UIFont? = UIFont(name: "Pretendard-Medium", size: 19)
    
    var body: some View {
        ZStack {
            VStack {
                Image("onBoarding_2")
                    .resizable()
                    .scaledToFill()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            
            VStack {
                
                Image(systemName: "bell.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .background() {
                        Circle()
                            .opacity(0.7)
                            .frame(width: 90, height: 90)
                    }
                    .padding(.top, 150)
                    .padding(.bottom, 30)
                
                Text("""
알림을 허용하면, 핀의 진심이 담긴 메세지를 받을 수 있어요.
""")
                if let unwrappedFont = optionalFontBold {
                    Text("""
    알림을 허용하면, 핀의 진심이 담긴 메세지를 받을 수 있어요.
    """)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(Font(unwrappedFont))
                    .lineSpacing(4)
                    .frame(maxWidth: 300)
                }
            
                Spacer()
                
                NavigationLink {
                    MainView()
                } label: {
                    Text("알림 설정")
                    if let unwrappedFont = optionalFontMedium {
                        Text("알림 설정")
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .font(Font(unwrappedFont))
                    }
                }
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding()
                .padding(.bottom, 40)
                .simultaneousGesture(TapGesture().onEnded {
                    /// 시스템 알림 허용 요청
                    localNotificationManager.requestNotificationPermission()
                })
            }
        }
    }
}

struct OnboardingView2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView2()
    }
}





struct ContentView: View {
    // Define an optional UIFont
    var optionalFont: UIFont? = UIFont(name: "Helvetica", size: 20)
    
    var body: some View {
        if let unwrappedFont = optionalFont {
            Text("Optional Font Example")
                .font(Font(unwrappedFont)) // Unwrapping the optional UIFont
        } else {
            Text("Default Font")
        }
    }
}
