//
//  ChuckchuDrivenDevelopmentApp.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/10.
//

import SwiftUI


@main
struct ChuckchuDrivenDevelopmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled = true // 다크 모드 상태를 저장하는 변수
    @AppStorage("firstInApp") var ifFirstInApp = true // 앱 첫 진입 여부를 저장하는 변수
    @State private var isLoading: Double = 1 // 스플릿뷰를 부르는 변수
    
    var body: some Scene {
        WindowGroup {
            Group {
                ZStack {
                    if ifFirstInApp == true {
                        NavigationStack {
                            OnBoardingView1()
                        }
                    } else {
                        MainView()
                    }
                    
                    SplashView()
                        .opacity(isLoading)
                        .animation(Animation.easeInOut(duration: 0.8), value: isLoading)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeInOut(duration: 2)) {
                                    isLoading = 0
                                }
                            }
                        }
                }
                
            }
            .preferredColorScheme(isDarkModeEnabled ? .dark : .light) // 다크 모드 상태에 따라 컬러 스킴 설정
        }
    }

}



// MARK: - Check If First In App (Method)
/// 온보딩뷰를 적절히 보여주기 위해, 사용자가 앱을 처음 진입했는지의 여부를 저장합니다.
public func checkIfFirstInApp() {
    UserDefaults.standard.set(false, forKey: "firstInApp")
}
