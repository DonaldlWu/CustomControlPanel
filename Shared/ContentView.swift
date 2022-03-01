//
//  ContentView.swift
//  Shared
//
//  Created by 吳得人 on 2022/3/1.
//

import SwiftUI

struct ContentView: View {
    @State var isShowPanel: Int = 0
    var body: some View {
        ZStack {
            ControlPanelView()
                .opacity(0.1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Using Example
struct ControlPanelView: View {
    var body: some View {
        HStack {
            SinglePanelView(imageName: "backward.end.alt.fill", action: { print(Control.backword) })
            SinglePanelView(imageName: "playpause.fill", action: { print(Control.backword) })
            SinglePanelView(imageName: "forward.end.alt.fill", action: { print(Control.backword) })
        }
    }
}

enum Control {
    case forword
    case backword
    case play
}
