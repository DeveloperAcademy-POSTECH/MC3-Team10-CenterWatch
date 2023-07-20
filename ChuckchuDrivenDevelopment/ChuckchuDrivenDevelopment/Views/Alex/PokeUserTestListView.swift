//
//  PokeUserTestListView.swift
//  CDDDD
//
//  Created by alex on 2023/07/18.
//

import SwiftUI

struct PokeUserTestListView: View {
    @EnvironmentObject var memberViewModel: MemberViewModel
   
    // FIXME: pushNotificationManager를 여기서까지 선언해야 하는가..
    @ObservedObject public var pushNotificationManager: PushNotificationManager = PushNotificationManager(
            currentUserDeviceToken: UserDefaults.standard.string(
                forKey: "userDeviceToken")
        )
    
    
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
                            let _: Void = await pushNotificationManager.sendNotification(userDeviceToken: member.deviceToken)
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
