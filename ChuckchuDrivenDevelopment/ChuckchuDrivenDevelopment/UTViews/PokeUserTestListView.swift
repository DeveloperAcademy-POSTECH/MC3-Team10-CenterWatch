//
//  PokeUserTestListView.swift
//  CDDDD
//
//  Created by alex on 2023/07/18.
//

import SwiftUI
/*
 
 struct PokeUserTestListView: View {
     @EnvironmentObject var memberViewModel: MemberViewModel
     @EnvironmentObject var pokeViewModel: PokeViewModel
    
     // FIXME: pushNotificationManager를 여기서까지 선언해야 하는가..
     @ObservedObject public var pushNotificationManager: PokeNotificationManager = PokeNotificationManager(
             currentUserDeviceToken: UserDefaults.standard.string(
                 forKey: "userDeviceToken")
         )
     
     // FIXME: 현재 로그인된 유저정보를 불러오는 임시 방편 / 추후에 방식 또는 위치 변경이 필요
     var currentMember: Member {
         var currentMember: Member = Member(id: "", username: "", deviceToken: "")
         for member in memberViewModel.members {
             if member.deviceToken == pushNotificationManager.currentUserDeviceToken {
                 currentMember = member
             }
         }
         return currentMember
     }
     
     
     var body: some View {
         
         List(memberViewModel.members) { member in
             /// 멤버 데이터에서 "나"의 정보를 제외한 멤버 리스트 불러오기
             if member.deviceToken != pushNotificationManager.currentUserDeviceToken {
                 HStack {
                     Image("turtle")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 80, height: 80)
                     
                     Text(member.username)
                     Spacer()
                     
                     
                     Button {
                         Task {
                             let _: Void = await pushNotificationManager.sendPokeNotification(toUserDeviceToken: member.deviceToken, currentMemberUsername: currentMember.username)
                             
                             // Poke 데이터를 만들어주고, createPoke()로 서버에 새 찌르기 객체 반영
                             let newPoke = Poke(id: UUID().uuidString, date: Date.now, fromID: currentMember.id, fromUsername: currentMember.username, toID: member.id, toUsername: member.username, reaction: "")
                             await pokeViewModel.createPoke(groupID: "4nnzFVSIKurIoNg5RvWI", with: newPoke)
                             
                         }
                     } label: {
                         Text("찌르기")
                             .foregroundColor(Color.accentColor)
                             .colorInvert() // FIXME: 컬러 어셋이 추가된 후 제거
                             .frame(maxWidth: 46, maxHeight: 48)
                             .padding(EdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 26))
                             .buttonStyle(.borderedProminent)
                             .background(RoundedRectangle(cornerRadius: 16).fill(Color.accentColor))
                     }
                     .buttonStyle(.borderedProminent)
                     
                 }
             }
         }
         .navigationTitle("꿋꿋단")
         .listStyle(PlainListStyle())
         .task {
             await memberViewModel.fetchMembers(groupID: "4nnzFVSIKurIoNg5RvWI")
         }
     }}



 struct PokeUserTestListView_Previews: PreviewProvider {
     static var previews: some View {
         PokeUserTestListView()
     }
 }

 
 */
