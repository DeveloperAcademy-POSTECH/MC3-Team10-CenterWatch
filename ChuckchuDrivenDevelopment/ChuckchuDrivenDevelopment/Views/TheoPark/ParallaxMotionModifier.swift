//
//  ParallaxMotionModifier.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/30.
//

import SwiftUI
import CoreMotion

struct ParallaxMotionModifier: ViewModifier {
    @Environment(\.scenePhase) var scenePhase
    
    @ObservedObject var manager: MotionManager
    var magnitude3d: Double
    var magnitude2d: Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(manager.roll * magnitude3d / 10), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.degrees(manager.pitch * magnitude3d / 3 - 1), axis: (x: -1, y: 0, z: 0))
            .offset(x: CGFloat(manager.roll * magnitude2d), y: CGFloat(manager.pitch * magnitude2d))
            .onChange(of: scenePhase) { newValue in
                if newValue == .inactive || newValue == .background {
                    manager.manager.stopDeviceMotionUpdates()
                } else { manager.startMotion() }
            }
    }
}

class MotionManager: ObservableObject {

    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    
    var manager: CMMotionManager
    
//    private var initalRoll: Double = 0
//    private var tempRoll: Double = 0
//    private var initalPitch: Double = 0
//    @State private var initalOn: Bool = false

    init() {
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 1/120
        startMotion()
    }
    
    func startMotion() {
        var initalRoll: Double = 0
        var tempRoll: Double = 0
//        var initalPitch: Double = 0
        @State var initalOn: Bool = false
        
        
        self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }

            if let motionData = motionData {
                self.pitch = 0
                
                ///범위를 +-3.13으로 고정
                if(motionData.attitude.roll >= 3.13) {
                    tempRoll = 3.13
                } else if(motionData.attitude.roll <= -3.13) {
                    tempRoll = -3.13
                } else {
                    tempRoll = motionData.attitude.roll
                }
                
                ///초기값 가져오기
                if(initalRoll == 0) {
                    initalRoll = motionData.attitude.roll
                }
                
                if(initalRoll < 0) {
                    if(tempRoll > 3.13 + initalRoll) {
                        tempRoll = tempRoll - 6.26
                    }
                    self.roll = tempRoll - initalRoll
                } else if(initalRoll >= 0) {
                    if(tempRoll < -3.13 + initalRoll) {
                        tempRoll = tempRoll + 6.26
                    }
                    self.roll = tempRoll + initalRoll
                }
                
                if(self.roll > 0.5) {
                    self.roll = 0.5
                } else if(self.roll < -0.5) {
                    self.roll = -0.5
                }
                
        
//                if(motionData.attitude.roll >= 1) {
//                    self.roll = 1
//                } else if(motionData.attitude.roll <= -1) {
//                    self.roll = -1
//                } else {
//                    self.roll = motionData.attitude.roll
//                }
//
//
                
//                print("self.roll"+"\(self.roll)")
//                print("inital.roll"+"\(self.initalRoll)")
                
            }
        }
    }
}
