//
//  touchDownGestureModifier.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/08/11.
//
import SwiftUI

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let callback: () -> Void
    var shrinkRate: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(CGSize(width: self.tapped ? shrinkRate : 1, height: self.tapped ? shrinkRate : 1), anchor: .center)
            .animation(.easeOut(duration: 0.2), value: self.tapped)
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !self.tapped {
                        self.tapped = true
                        self.callback()
                    }
                }
                .onEnded { _ in
                    self.tapped = false
                })
    }
}

extension View {
    func onTouchDownGesture(shrinkRate: Double, callback: @escaping () -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(callback: callback, shrinkRate: shrinkRate))
    }
}
