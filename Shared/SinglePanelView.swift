//
//  SinglePanelView.swift
//  CustomControlPanel
//
//  Created by 吳得人 on 2022/3/1.
//

import SwiftUI

struct SinglePanelView: View {
    @State private var startAnimation: Bool = false
    @State private var bgAnimation: Bool = false
    // Resetting
    @State private var resetBG: Bool = false
    @State private var animationEnded: Bool = false
    @State private var tapComplete: Bool = false
    
    var imageName: String = ""
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Image(systemName: imageName)
                .font(.system(size: 22))
                .foregroundColor(.gray)
            // Scaling ...
                .scaleEffect(startAnimation ? 1 : 0.01)
            // Background Animation
                .background(
                    ZStack {
                        CustomCircleShape(radius: resetBG ? 200 : 0)
                            .fill(Color.gray)
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                            .scaleEffect(bgAnimation ? 2.2 : 0.01)
                            .opacity(animationEnded ? 0 : 1)
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .opacity(animationEnded ? 0 : 1)
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.1)
        }
        .onTapGesture(count: 2) {
            
            if tapComplete {
                startAnimation = false
                bgAnimation = false
                resetBG = false
                animationEnded = false
                tapComplete = false
                return
            }
            
            if startAnimation {
                return
            }
            
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                startAnimation = true
            }
            
            // Sequence Animation ...
            // Chain Animation ...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                    bgAnimation = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                        resetBG = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.easeOut(duration: 0.4)) {
                            animationEnded = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            tapComplete = true
                        }
                    }
                }
            }
        }
        
    }
}

struct SinglePanelView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomCircleShape: Shape {
    var radius: CGFloat
    
    // animating path ...
    var animatableData: CGFloat {
        get {return radius}
        set {radius = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            // Adding Center Circle
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            path.move(to: center)
            path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .init(degrees: 360), clockwise: false)
        }
    }
}
