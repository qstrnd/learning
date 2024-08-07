//
//  PlaygroundConfigurationItemFactory.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-06.
//

import Foundation

final class DefaultPlaygroundConfigurationItemFactory: PlaygroundConfigurationItemFactory {
    func createContentItems() -> [PlaygroundConfigurationView.ContentItem] {
        [
            .clearInteractiveViewsButton
        ]
    }
}
