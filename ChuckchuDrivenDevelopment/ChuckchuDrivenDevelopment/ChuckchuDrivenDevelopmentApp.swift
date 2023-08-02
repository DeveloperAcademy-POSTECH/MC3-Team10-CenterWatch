//
//  ChuckchuDrivenDevelopmentApp.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/10.
//

import SwiftUI


@main
struct ChuckchuDrivenDevelopmentApp: App {
    
    
    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled = true // 다크 모드 상태를 저장하는 변수
    @State private var showContent = false // 스플릿뷰를 부르는 변수
    
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showContent {
                    MainView()
                    
                } else {
                    SplashView()
                    
                }
            }
            .preferredColorScheme(isDarkModeEnabled ? .dark : .light) // 다크 모드 상태에 따라 컬러 스킴 설정
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    showContent = true
                }
            }
            
        }
    }
}
