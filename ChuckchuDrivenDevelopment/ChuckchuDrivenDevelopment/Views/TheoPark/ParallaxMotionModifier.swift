//
//  ParallaxMotionModifier.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/30.
//

import SwiftUI
import CoreMotion

struct ParallaxMotionModifier: ViewModifier {
    
    @ObservedObject var manager: MotionManager
    var magnitude3d: Double
    var magnitude2d: Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(manager.roll * magnitude3d / 5), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.degrees(manager.pitch * magnitude3d / 5 - 1), axis: (x: -1, y: 0, z: 0))
            .offset(x: CGFloat(manager.roll * magnitude2d), y: CGFloat(manager.pitch * magnitude2d / 2))
    }
}

class MotionManager: ObservableObject {

    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    
    private var manager: CMMotionManager

    init() {
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 1/120
        self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }

            if let motionData = motionData {
                self.pitch = motionData.attitude.pitch
                self.roll = motionData.attitude.roll
            }
        }

    }
}
