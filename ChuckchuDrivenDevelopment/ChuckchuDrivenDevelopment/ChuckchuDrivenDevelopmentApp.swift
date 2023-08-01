//
//  ChuckchuDrivenDevelopmentApp.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/10.
//

import SwiftUI


@main
struct ChuckchuDrivenDevelopmentApp: App {

  var body: some Scene {
    WindowGroup {
      NavigationView {
          MainView()
              .preferredColorScheme(.dark)
      }
    }
  }
}
