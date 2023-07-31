//
//  ContentView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by Ye Eun Choi on 2023/07/10.
//

import SwiftUI

/*
 
 struct ContentView: View {
     @EnvironmentObject var memberViewModel: MemberViewModel
    
     @ObservedObject public var pushNotificationManager: PokeNotificationManager = PokeNotificationManager(
             currentUserDeviceToken: UserDefaults.standard.string(
                 forKey: "userDeviceToken")
         )
   
  
     var body: some View {
         VStack {
             /// 로그인 이력(서버에 기기 토큰)이 있으면 찌르기 리스트 뷰로, 없으면 로그인 뷰로 이동
             // TODO: - 로그인 기능 추가 후 아래 조건 변경
             if let currentUserDeviceToken = pushNotificationManager.currentUserDeviceToken {
                 if memberViewModel.members.map({ $0.deviceToken }).contains(currentUserDeviceToken) {
                     PokeUserTestListView()

                 } else {
                     PokeUserTestNameView()
                 }
                 
             }
         }
         .task {
             await memberViewModel.fetchMembers(groupID: "4nnzFVSIKurIoNg5RvWI")
         }

     }
     
 }
 
 
 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }


 
 
 */



