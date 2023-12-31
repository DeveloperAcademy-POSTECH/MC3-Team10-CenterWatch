//
//  SplashView.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/07/24.
//

import SwiftUI

struct SplashView: View {
    
    ///뒷배경 Blur 애니메이션 효과를 위한 변수
    @State private var splashOn: Bool = false
    @State private var animationPaused = false // Set default value here
    @State private var grayscale = 0.0 // Set default value here
    var body: some View {
            
        VStack {
            ///작은 거북이, 화면을 가득채우는 크기의 0.3배
            CharacterAnimation(animationPaused: $animationPaused, grayscale: $grayscale)
                .aspectRatio(contentMode: .fit)
                .scaleEffect(0.3)
            
            /// 애니메이션 효과가 들어가있는 뒷배경
                .background() {
                    ZStack {
                        Image("Pin3D1")
                            .blur(radius: 16)
                            .scaleEffect(4)
                            .overlay() {
                                VStack {
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.blue)
                                .scaleEffect(4)
                                .blendMode(.overlay)
                        }
                        
                        Image("Pin3D1")
                            .blur(radius: 16)
                            .scaleEffect(4)
                            .overlay() {
                                VStack {
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.blue)
                                .scaleEffect(4)
                                .blendMode(.overlay)
                        }
                        
                        Image("Pin3D1")
                            .blur(radius: 16)
                            .scaleEffect(4)
                            .overlay() {
                                VStack {
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.blue)
                                .scaleEffect(4)
                                .blendMode(.overlay)
                        }
                    }
                }
        }
        .onAppear() {
                splashOn.toggle()
            
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
