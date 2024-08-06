//
//  MainViewController+LayoutManager.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-06.
//

import UIKit

protocol ViewControllerLayoutManager {
    func setupInitialConstraints(isExpanded: Bool)
    func updateConstraints(isExpanded: Bool)
    func calculateTopInsetForPlaygroundConfigurationViewContent() -> CGFloat
}

extension MainViewController {
    final class LayoutManager {
        private var innerLayoutManager: ViewControllerLayoutManager?

        private let parentView: UIView
        private let playgroundView: UIView
        private let playgroundConfigurationView: UIView

        init(parentView: UIView, playgroundView: UIView, playgroundConfigurationView: UIView) {
            self.parentView = parentView
            self.playgroundView = playgroundView
            self.playgroundConfigurationView = playgroundConfigurationView
        }

        func setupInitialConstraints(isExpanded: Bool) {
            innerLayoutManager?.setupInitialConstraints(isExpanded: isExpanded)
        }

        func updateConstraints(isExpanded: Bool) {
            innerLayoutManager?.updateConstraints(isExpanded: isExpanded)
        }

        func calculateTopInsetForPlaygroundConfigurationViewContent() -> CGFloat {
            innerLayoutManager?.calculateTopInsetForPlaygroundConfigurationViewContent() ?? 0
        }

        func prepare(for orientation: UIDeviceOrientation) {
            guard orientation != .unknown else { return }

            // as of now, I haven't found anything better than to remove and add back the views to apply constraints change
            [playgroundConfigurationView, playgroundView].forEach { $0.removeFromSuperview() }
            parentView.addSubview(playgroundConfigurationView)
            parentView.addSubview(playgroundView)

            innerLayoutManager = orientation.isPortrait ? PortraitLayoutManager(parentView: parentView, playgroundView: playgroundView, playgroundConfigurationView: playgroundConfigurationView) : LandscapeLayoutManager(parentView: parentView, playgroundView: playgroundView, playgroundConfigurationView: playgroundConfigurationView)
        }
    }

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

        func calculateTopInsetForPlaygroundConfigurationViewContent() -> CGFloat {
            let frame = playgroundConfigurationView.convert(playgroundView.frame, from: parentView)
            return frame.maxY + .doublePadding - playgroundConfigurationView.safeAreaInsets.top
        }
    }

    final class LandscapeLayoutManager: ViewControllerLayoutManager {
        private let parentView: UIView
        private let playgroundView: UIView
        private let playgroundConfigurationView: UIView

        private lazy var playgroundViewTopToSafeAreaAnchor = playgroundView.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: .doublePadding)
        private lazy var playgroundViewBottomToSafeAreaAnchor = playgroundView.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor)
        private lazy var playgroundViewLeadingToSafeAreaAnchor = playgroundView.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor)
        private lazy var playgroundViewTrailingToCenterXAnchor = playgroundView.trailingAnchor.constraint(equalTo: parentView.centerXAnchor)

        private lazy var playgroundViewExpandedTopAnchor = playgroundView.topAnchor.constraint(equalTo: parentView.topAnchor)
        private lazy var playgroundViewExpandedBottomAnchor = playgroundView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        private lazy var playgroundViewExpandedLeadingAnchor = playgroundView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor)
        private lazy var playgroundViewExpandedTrailingAnchor = playgroundView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)

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
            let nonExpandedConstraints = [
                playgroundViewTopToSafeAreaAnchor,
                playgroundViewBottomToSafeAreaAnchor,
                playgroundViewLeadingToSafeAreaAnchor,
                playgroundViewTrailingToCenterXAnchor
            ]

            let expandedConstraints = [
                playgroundViewExpandedTopAnchor,
                playgroundViewExpandedBottomAnchor,
                playgroundViewExpandedLeadingAnchor,
                playgroundViewExpandedTrailingAnchor
            ]

            NSLayoutConstraint.activate(isExpanded ? expandedConstraints : nonExpandedConstraints)
            NSLayoutConstraint.deactivate(isExpanded ? nonExpandedConstraints : expandedConstraints)
        }

        private func setupPlaygroundView() {
            playgroundView.translatesAutoresizingMaskIntoConstraints = false
        }

        private func setupPlaygroundConfigurationView() {
            playgroundConfigurationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                playgroundConfigurationView.leadingAnchor.constraint(equalTo: parentView.centerXAnchor, constant: .doublePadding),
                playgroundConfigurationView.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor),
                playgroundConfigurationView.topAnchor.constraint(equalTo: parentView.topAnchor),
                playgroundConfigurationView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            ])
        }

        func calculateTopInsetForPlaygroundConfigurationViewContent() -> CGFloat { 0 }
    }
}
