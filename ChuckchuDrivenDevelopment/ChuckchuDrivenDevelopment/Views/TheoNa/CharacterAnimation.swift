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

       var body: some View {
           Image("Pheen\(currentFrameIndex + 1)")
               .resizable()
               .scaledToFit()
               .onAppear {
                   startAnimation()
               }
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
