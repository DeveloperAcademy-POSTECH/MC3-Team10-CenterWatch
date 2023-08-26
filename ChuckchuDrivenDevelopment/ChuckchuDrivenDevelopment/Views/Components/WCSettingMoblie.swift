//
//  WatctConnect.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/08/26.
//

import SwiftUI
import WatchConnectivity

final class WCSettingMobile: NSObject, WCSessionDelegate, ObservableObject {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
}
