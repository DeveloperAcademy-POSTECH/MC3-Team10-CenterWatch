//
//  CharacterAnimation.swift
//  ChuckchuDrivenDevelopment
//
//  Created by been on 2023/07/25.
//

import SwiftUI

struct CharacterAnimation: View {
    @State private var currentFrameIndex = 0
    
    @State private var is3DImage = true
    @State private var tapCount = 0
    
    @State var points: [CGPoint] = [CGPoint.init(x: 2000, y: 2000)]
    @State var dragLocation: CGPoint?
    @State var tapLocation: CGPoint?
    
    @State private var tapped = false
    
    @Binding var animationPaused: Bool
    @Binding var grayscale: Double
    
    private let totalFrames = 4 // 전체 프레임 개수
    
    var body: some View {
        
        let tapDetector = TapGesture()
            .onEnded {
                if is3DImage {
                    tapCount += 1
                    if tapCount == 10 {
                        is3DImage = false
                        tapCount = 0
                    }
                } else {
                    is3DImage = true
                }
                self.tapped = false
                
            }
        
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { value in
                if !self.tapped {
                    self.tapped = true
                    
                    self.dragLocation = value.location
                    tapLocation = dragLocation
                    guard let point = tapLocation else {
                        return
                    }
                    points.append(point)
                    let impactHeavy = UIImpactFeedbackGenerator(style: .light)
                    impactHeavy.impactOccurred()
                }
                
            }
        
        
        ZStack {
            VStack {
                if(!is3DImage) {
                    HStack {
                        Text("Apple Developer Academy @ Postech")
                        
                        Spacer()
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, -100)
                    .padding(.top, 16)
                    .font(Font.custom("Pretendard-Bold", size: 26))
                    .opacity(0.7)
                    
                }
                
                Image(is3DImage ? "Pin3D\(currentFrameIndex + 1)" :
                        "Pin2D\(currentFrameIndex + 1)")
                .resizable()
                .scaledToFit()
                .onAppear {
                    startAnimation()
                }
                
                if(!is3DImage) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Mini Challenge 3")
                            Text("Team 10")
                            Text("")
                            Text("세상의 중심에서 시계를 와치다")
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Guardy / 김수호")
                            Text("Theo(Park) / 박상준")
                            Text("Lianne / 최예은")
                            Text("Alex / 이도후")
                            Text("Theo(Na) / 나경빈")
                        }
                    }
                    .padding(.top, -90)
                    .padding(.horizontal, 32)
                    .foregroundColor(.white)
                    .font(Font.custom("Pretendard-Bold", size: 16))
                    .opacity(0.8)
                }
            }
            
            
            .grayscale(grayscale) // Apply grayscale based on the binding
            ForEach(points.indices, id: \.self) { index in
                CreateCircle(location: points[index])
            }
            
        }
        .gesture(dragGesture.sequenced(before: tapDetector))
        
    }
    private func startAnimation() {
        // Timer를 사용하여 0.05초마다 다음 프레임으로 이동하여 애니메이션 생성
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            withTransaction(Transaction(animation: nil)) {
                if !animationPaused {
                    currentFrameIndex = (currentFrameIndex + 1) % totalFrames
                }
            }
        }
    }
}


struct CharacterAnimation_Previews: PreviewProvider {
    @State static private var animationPaused = false
    @State static private var grayscale = 0.0
    
    static var previews: some View {
        CharacterAnimation(animationPaused: $animationPaused, grayscale: $grayscale)
            .preferredColorScheme(.dark)
    }
}
