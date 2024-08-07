//
//  PlaygroundViewModel.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-08.
//

import UIKit

extension PlaygroundView {
    final class ViewModel {
        unowned var view: PlaygroundView!

        lazy var removeAllItemsPublisher = interactiveObjectsManager.removeAllItemsPublisher

        private let interactiveObjectsManager: InteractiveObjectsManaging

        private lazy var animator = UIDynamicAnimator(referenceView: view)

        private lazy var gravityBehavor: UIGravityBehavior = {
            let behavior = UIGravityBehavior()
            animator.addBehavior(behavior)

            return behavior
        }()

        private lazy var collisionBehavior: UICollisionBehavior = {
            let behavior = UICollisionBehavior()
            behavior.translatesReferenceBoundsIntoBoundary = true
            animator.addBehavior(behavior)

            return behavior
        }()

        private(set) var interactiveSubviews: Set<UIView> = []

        init(interactiveObjectsManager: InteractiveObjectsManaging) {
            self.interactiveObjectsManager = interactiveObjectsManager
        }

        func removeAllInteractiveSubviews() -> [UIView] {
            self.interactiveSubviews.forEach {
                self.removeDynamics(from: $0)
            }

            let removedSubviews = interactiveSubviews
            interactiveSubviews = []
            interactiveObjectsManager.resetCount()
            return Array(removedSubviews)
        }

        func registerInteractiveSubview(_ view: UIView) {
            interactiveObjectsManager.increaseCount()
            interactiveSubviews.insert(view)
            addDynamics(to: view)
        }

        private func addDynamics(to subview: UIView) {
            collisionBehavior.addItem(subview)
            gravityBehavor.addItem(subview)
        }

        private func removeDynamics(from subview: UIView) {
            collisionBehavior.removeItem(subview)
            gravityBehavor.removeItem(subview)
        }
    }
}
