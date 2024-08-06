//
//  MainViewController+LayoutManager.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-06.
//

import UIKit

protocol ViewControllerLayoutManager {
    init(parentView: UIView, playgroundView: UIView, playgroundConfigurationView: UIView)
    func setupInitialConstraints(isExpanded: Bool)
    func updateConstraints(isExpanded: Bool)
}

extension MainViewController {
    final class PortraitLayoutManager: ViewControllerLayoutManager {
        private let parentView: UIView
        private let playgroundView: UIView
        private let playgroundConfigurationView: UIView

        private lazy var playgroundViewTopToSafeAreaAnchor = playgroundView.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor)
        private lazy var playgroundViewTopToEdgeAnchor = playgroundView.topAnchor.constraint(equalTo: parentView.topAnchor)
        private lazy var playgroundViewBottomToParentCenterConstraint = playgroundView.bottomAnchor.constraint(equalTo: parentView.centerYAnchor)
        private lazy var playgroundViewBottomToFullHeightConstraint = playgroundView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        private lazy var playgroundViewLeadingConstraint = playgroundView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor)
        private lazy var playgroundViewTrailingConstraint = playgroundView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)

        init(
            parentView: UIView,
            playgroundView: UIView,
            playgroundConfigurationView: UIView
        ) {
            self.parentView = parentView
            self.playgroundView = playgroundView
            self.playgroundConfigurationView = playgroundConfigurationView
        }

        func setupInitialConstraints(isExpanded: Bool) {
            setupPlaygroundView()
            setupPlaygroundConfigurationView()
            updateConstraints(isExpanded: isExpanded)
        }

        func updateConstraints(isExpanded: Bool) {
            playgroundViewLeadingConstraint.constant = isExpanded ? 0 : .standardPadding
            playgroundViewTrailingConstraint.constant = isExpanded ? 0 : -.standardPadding

            playgroundViewBottomToFullHeightConstraint.isActive = isExpanded
            playgroundViewBottomToParentCenterConstraint.isActive = !isExpanded

            playgroundViewTopToEdgeAnchor.isActive = isExpanded
            playgroundViewTopToSafeAreaAnchor.isActive = !isExpanded
        }

        private func setupPlaygroundView() {
            playgroundView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                playgroundViewLeadingConstraint,
                playgroundViewTrailingConstraint
            ])
        }

        private func setupPlaygroundConfigurationView() {
            playgroundConfigurationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                playgroundConfigurationView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                playgroundConfigurationView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
                playgroundConfigurationView.topAnchor.constraint(equalTo: parentView.topAnchor),
                playgroundConfigurationView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            ])
        }


    }
}
