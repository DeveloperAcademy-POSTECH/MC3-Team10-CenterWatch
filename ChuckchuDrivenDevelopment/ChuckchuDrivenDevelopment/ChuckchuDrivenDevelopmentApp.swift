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
    @State private var isLoading: Bool = false // 스플릿뷰를 부르는 변수
    
    
    var body: some Scene {
        WindowGroup {
            Group {
                ZStack {
                    MainView()
                    
                    SplashView()
                        .opacity(isLoading ? 0 : 1)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation(.easeInOut(duration: 2)) {
                                    isLoading.toggle()
                                }
                            }
                        }
                }
            }
            .preferredColorScheme(isDarkModeEnabled ? .dark : .light) // 다크 모드 상태에 따라 컬러 스킴 설정
            
            
        }
    }
}
