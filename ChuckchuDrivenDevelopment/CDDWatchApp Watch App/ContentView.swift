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
        ///iOS에서 값을 받지 못했다면
        if(watchConnecter.data[0] == -1) {
            Text(String(localized: "Please complete the settings in the Ggood Ggood iOS app!"))
        } else {
            List {
                VStack(alignment: .leading) {
                    Text(String(localized: "Start Time"))
                    Text(String(format: "%02d", watchConnecter.data[0]) + ":00")
                        .font(.title).bold()
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading) {
                    Text(String(localized: "End Time"))
                    Text(String(format: "%02d", watchConnecter.data[1]) + ":00")
                        .font(.title).bold()
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading) {
                    Text(String(localized: "Notification Interval"))
                    Text(String("\(watchConnecter.data[2]/60)" + String(localized: "Hour")))
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
