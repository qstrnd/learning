//
//  MetalRenderer.swift
//  MetalLearning
//
//  Created by Andy on 2024-07-23.
//

import MetalKit

final class MetalRenderer: NSObject, MTKViewDelegate {
    let device: MTLDevice

    init(device: MTLDevice) {
        self.device = device
        super.init()
    }

    func draw(in view: MTKView) {

    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {

    }
}
