//
//  SinglePanelView.swift
//  CustomControlPanel
//
//  Created by 吳得人 on 2022/3/1.
//

import SwiftUI

struct SinglePanelView: View {
    @State private var startAnimation: Bool = false
    var imageName: String = ""
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Image(systemName: imageName)
                .font(.system(size: 22))
                .foregroundColor(.gray)
                // Scaling ...
                .scaleEffect(startAnimation ? 1 : 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.1)
        }
        .onTapGesture(count: 2) {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                startAnimation = true
            }
        }
        
    }
}

struct SinglePanelView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
