//
//  ChuckchuDrivenDevelopmentApp.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/10.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


@main
struct ChuckchuDrivenDevelopmentApp: App {
  // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor var delegate: AppDelegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
          NotificationTestingView()
      }
    }
  }
}
