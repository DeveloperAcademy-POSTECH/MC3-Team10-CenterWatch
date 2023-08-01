//
//  CharacterAnimation.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/07/25.
//

import SwiftUI

struct CharacterAnimation: View {
    @State private var currentFrameIndex = 0
    private let totalFrames = 4 // 전체 프레임 개수
    @State private var is3DImage = true
    @State private var tapCount = 0
    
    var body: some View {
        Image(is3DImage ? "pin3d\(currentFrameIndex + 1)" :
                "pin2d\(currentFrameIndex + 1)")
        .resizable()
        .scaledToFit()
        .onAppear {
            startAnimation()
        }
        .gesture(
            TapGesture(count: 1)
                .onEnded {
                    if is3DImage {
                        tapCount += 1
                        if tapCount == 5 {
                            is3DImage = false
                            tapCount = 0
                        }
                    } else {
                        is3DImage = true
                    }
                }
        )
        
    }
    
    private func startAnimation() {
        // Timer를 사용하여 0.05초마다 다음 프레임으로 이동하여 애니메이션 생성
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            withTransaction(Transaction(animation: nil)) {
                currentFrameIndex = (currentFrameIndex + 1) % totalFrames
            }
        }
    }
}


struct CharacterAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CharacterAnimation()
    }
}
