// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import UIKit

extension PlaygroundView {
    final class ViewModel {
        unowned var view: PlaygroundView!

        lazy var removeAllItemsPublisher = interactiveObjectsManager.removeAllItemsPublisher
        let preferencesProvider: InteractiveObjectsPreferencesProvider

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

        init(
            interactiveObjectsManager: InteractiveObjectsManaging,
            preferencesProvider: InteractiveObjectsPreferencesProvider
        ) {
            self.interactiveObjectsManager = interactiveObjectsManager
            self.preferencesProvider = preferencesProvider
        }

        func removeAllInteractiveSubviews() -> [UIView] {
            for interactiveSubview in self.interactiveSubviews {
                self.removeDynamics(from: interactiveSubview)
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
