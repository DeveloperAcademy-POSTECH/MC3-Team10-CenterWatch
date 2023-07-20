//
//  PokeUserTestNameView.swift
//  CDDDD
//
//  Created by alex on 2023/07/18.
//

import SwiftUI

struct PokeUserTestNameView: View {
    @EnvironmentObject var memberViewModel: MemberViewModel
    // FIXME: pushNotificationManager를 여기서까지 선언해야 하는가..
    @ObservedObject public var pushNotificationManager: PushNotificationManager = PushNotificationManager(
            currentUserDeviceToken: UserDefaults.standard.string(
                forKey: "userDeviceToken")
        )
   
    @State var name: String = ""
    
    var body: some View {
        
        VStack {
            Image("turtle")
            
            TextField("닉네임을 입력해주세요.", text: $name)
                .font(Font.system(size: 16))
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(uiColor: .systemGray6)))
                .padding()
                .foregroundColor(.white)
            
            
            if name.trimmingCharacters(in: .whitespaces) != "" {
                NavigationLink(destination: PokeUserTestHomeView()){
                    Text("완료")
                        .foregroundColor(Color.accentColor)
                        .colorInvert() // FIXME: 컬러 어셋이 추가된 후 제거
                        .frame(maxWidth: 96, maxHeight: 60)
                        .padding(EdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 26))
                        .buttonStyle(.borderedProminent)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.accentColor))
                }
                .simultaneousGesture(TapGesture().onEnded {
                    Task {
                        if let deviceToken = pushNotificationManager.currentUserDeviceToken {
                            let member = Member(id: UUID().uuidString, username: name, deviceToken: deviceToken)
                            await memberViewModel.createMember(groupID: "4nnzFVSIKurIoNg5RvWI", with: member)
                        }
                        
                    }
                })
            }

        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
         
    }
    
}

struct PokeUserTestNameView_Previews: PreviewProvider {
    static var previews: some View {
        PokeUserTestNameView()
    }
}
