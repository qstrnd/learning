// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import SpriteKit
import SwiftUI

struct ContentView: View {
    var scene: SKScene {
        let scene = SnowScene()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear

        return scene
    }

    var body: some View {
        ZStack {
            Color(red: 0.0, green: 0.12, blue: 0.32)
                .ignoresSafeArea()
            SpriteView(scene: scene, options: [.allowsTransparency])
                .ignoresSafeArea()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
