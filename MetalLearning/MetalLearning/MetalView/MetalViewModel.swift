//
//  MetalViewModel.swift
//  MetalLearning
//
//  Created by Andy on 2024-07-23.
//

import MetalKit
import SwiftUI

final class MetalViewModel: ObservableObject {
    enum Error: Swift.Error {
        case cannotCreateDevice
    }

    enum State {
        case unspecified
        case canDraw(MetalRenderer)
        case error(Error)
    }

    @Published var state: State = .unspecified

    func onAppear() {
        guard let metalRendererDependencies = MetalRendererDependencies() else {
            state = .error(.cannotCreateDevice)
            return
        }
        
        let renderer = MetalRenderer(dependencies: metalRendererDependencies)
        state = .canDraw(renderer)
    }

}
