//
//  MetalView.swift
//  MetalLearning
//
//  Created by Andy on 2024-07-23.
//

import MetalKit
import SwiftUI

struct MetalView: View {
    @StateObject private var viewModel = MetalViewModel()

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .unspecified:
                EmptyView()
            case .canDraw(let metalRenderer):
                MetalViewImpl(renderer: metalRenderer)
            case .error(let error):
                Text(error.localizedDescription)
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}


#Preview {
    MetalView()
}
