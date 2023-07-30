//
//  ChuckchuDrivenDevelopmentApp.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/10.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct ChuckchuDrivenDevelopmentApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    
  var body: some Scene {
    WindowGroup {
      NavigationView {
          MainView()
              .preferredColorScheme(.dark)
              .environmentObject(UserViewModel())
              .environmentObject(LocalNotificationManager())
      }
    }
  }
}
