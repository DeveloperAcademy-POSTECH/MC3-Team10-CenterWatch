//
//  ContentView.swift
//  CDDWatchApp Watch App
//
//  Created by Ye Eun Choi on 2023/07/10.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var watchConnecter = WCSettingInformation()
    
    func getDataFromUserData() {
        
        if let recivedData = UserDefaults.standard.array(forKey: "data") {
            watchConnecter.data = recivedData as! [Int]
        } else {
            watchConnecter.data = [-1, -1, 60]
        }
    }
    
    var body: some View {
        if(watchConnecter.data[0] == -1) {
            Text("꿋꿋 iOS앱에서 설정을 완료해주세요!")
        } else {
            List {
                VStack(alignment: .leading) {
                    Text("시작 시간")
                    Text(String(format: "%02d", watchConnecter.data[0]) + ":00")
                        .font(.title).bold()
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading) {
                    Text("종료 시간")
                    Text(String(format: "%02d", watchConnecter.data[1]) + ":00")
                        .font(.title).bold()
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading) {
                    Text("알림 주기")
                    Text(String("\(watchConnecter.data[2]/60)" + "시간"))
                        .font(.title).bold()
                        .foregroundColor(.blue)
                }
            }
            .onAppear() {
                getDataFromUserData()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
