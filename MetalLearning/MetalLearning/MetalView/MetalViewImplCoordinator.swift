//
//  MetalViewImplCoordinator.swift
//  MetalLearning
//
//  Created by Andy on 2024-07-23.
//

import SwiftUI
import MetalKit

final class MetalViewImplCoordinator: NSObject, MTKViewDelegate {
    private let parent: MetalViewImpl

    let renderer: MetalRenderer

    init(_ parent: MetalViewImpl, renderer: MetalRenderer) {
        self.parent = parent
        self.renderer = renderer
    }

    func draw(in view: MTKView) {
        renderer.draw(in: view)
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        renderer.mtkView(view, drawableSizeWillChange: size)
    }
}
