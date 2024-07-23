//
//  MetalRenderer.swift
//  MetalLearning
//
//  Created by Andy on 2024-07-23.
//

import MetalKit

final class MetalRendererDependencies {
    let device: MTLDevice
    let commandQueue: MTLCommandQueue

    init?() {
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let commandQueue = device.makeCommandQueue()
        else {
            return nil
        }

        self.device = device
        self.commandQueue = commandQueue
    }
}

final class MetalRenderer: NSObject, MTKViewDelegate {
    let dependencies: MetalRendererDependencies

    init(dependencies: MetalRendererDependencies) {
        self.dependencies = dependencies
        super.init()
    }

    func draw(in view: MTKView) {
        guard 
            let renderPassDescriptor = view.currentRenderPassDescriptor,
            let colorAttachment = renderPassDescriptor.colorAttachments[0]
        else {
            return
        }

        colorAttachment.clearColor = MTLClearColor(red: 0.8, green: 0.5, blue: 0.5, alpha: 1.0)
        colorAttachment.loadAction = .clear
        colorAttachment.storeAction = .store

        guard
            let currentDrawable = view.currentDrawable,
            let commandBuffer = dependencies.commandQueue.makeCommandBuffer(),
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
            return
        }

        renderEncoder.endEncoding()

        commandBuffer.present(currentDrawable)
        commandBuffer.commit()
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {

    }
}
