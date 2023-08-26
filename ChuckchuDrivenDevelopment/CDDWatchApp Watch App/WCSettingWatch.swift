//
//  WCInformationWatch.swift
//  CDDWatchApp Watch App
//
//  Created by 박상준 on 2023/08/26.
//

import SwiftUI
import Foundation
import WatchConnectivity

final class WCSettingInformation: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    @Published var data: [Int] = [0, 0, 0]
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.data = message["data"] as? [Int] ?? [-1, -1, -1]
            UserDefaults.standard.set(self.data, forKey: "data")
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            self.data = applicationContext["update"] as? [Int] ?? [-1, -1, -1]
            UserDefaults.standard.set(self.data, forKey: "data")
        }
    }
}

