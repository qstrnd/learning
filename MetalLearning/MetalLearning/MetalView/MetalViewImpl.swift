//
//  MetalViewImpl.swift
//  MetalLearning
//
//  Created by Andy on 2024-07-23.
//

import MetalKit
import SwiftUI

struct MetalViewImpl: UIViewRepresentable {
    private let renderer: MetalRenderer

    init(renderer: MetalRenderer) {
        self.renderer = renderer
    }

    func makeUIView(context: UIViewRepresentableContext<MetalViewImpl>) -> MTKView {
        let metalView = MTKView()
        metalView.device = renderer.dependencies.device
        metalView.delegate = renderer
        metalView.preferredFramesPerSecond = 60
        metalView.enableSetNeedsDisplay = true
        metalView
            .framebufferOnly = false
        metalView.drawableSize = metalView.frame.size

        return metalView
    }

    func updateUIView(_ uiView: MTKView, context: UIViewRepresentableContext<MetalViewImpl>) {

    }
}
