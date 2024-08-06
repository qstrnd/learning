//
//  ViewController.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-07-23.
//

import UIKit

final class ViewController: UIViewController {

    private let playgroundView = PlaygroundView()
    private lazy var playgroundViewTopToSafeAreaAnchor = playgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    private lazy var playgroundViewTopToEdgeAnchor = playgroundView.topAnchor.constraint(equalTo: view.topAnchor)
    private lazy var playgroundViewBottomToParentCenterConstraint = playgroundView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
    private lazy var playgroundViewBottomToFullHeightConstraint = playgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    private lazy var playgroundViewLeadingConstraint = playgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    private lazy var playgroundViewTrailingConstraint = playgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    private var isPlaygroundViewExpanded = false {
        didSet {
            updatePlaygroundViewConstraints(animated: true)
            updateHidableContent(hide: isPlaygroundViewExpanded, animated: true)
        }
    }

    private let playgroundConfigurationView = PlaygroundConfigurationView(viewModel: .init(contentFactory:  DefaultPlaygroundConfigurationItemFactory()))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPlaygroundConfigurationView()
        setupPlaygroundView()
    }

    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
    }

    private func setupPlaygroundView() {
        playgroundView.delegate = self

        setupPlaygroundViewLayout()
    }

    private func setupPlaygroundViewLayout() {
        view.addSubview(playgroundView)

        playgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playgroundViewLeadingConstraint,
            playgroundViewTrailingConstraint
        ])

        updatePlaygroundViewConstraints()
    }

    private func updatePlaygroundViewConstraints(animated: Bool = false) {
        playgroundViewLeadingConstraint.constant = isPlaygroundViewExpanded ? 0 : .standardPadding
        playgroundViewTrailingConstraint.constant = isPlaygroundViewExpanded ? 0 : -.standardPadding

        playgroundViewBottomToFullHeightConstraint.isActive = isPlaygroundViewExpanded
        playgroundViewBottomToParentCenterConstraint.isActive = !isPlaygroundViewExpanded

        playgroundViewTopToEdgeAnchor.isActive = isPlaygroundViewExpanded
        playgroundViewTopToSafeAreaAnchor.isActive = !isPlaygroundViewExpanded

        if animated {
            UIView.animate(withDuration: 0.5, delay: 0.2) {
                self.view.layoutIfNeeded()
            }
        } else {
            view.setNeedsLayout()
        }
    }

    private func setupPlaygroundConfigurationView() {
        playgroundConfigurationView.delegate = self

        setupPlaygroundConfigurationViewLayout()
    }

    private func setupPlaygroundConfigurationViewLayout() {
        view.addSubview(playgroundConfigurationView)

        playgroundConfigurationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playgroundConfigurationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playgroundConfigurationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playgroundConfigurationView.topAnchor.constraint(equalTo: view.topAnchor),
            playgroundConfigurationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func updateHidableContent(hide: Bool, animated: Bool = false) {
        let isInitiallyHidden = !hide
        playgroundConfigurationView.alpha = isInitiallyHidden ? 0 : 1
        playgroundConfigurationView.isHidden = isInitiallyHidden

        UIView.animate(withDuration: animated ? 0.2 : 0) {
            self.playgroundConfigurationView.alpha = self.isPlaygroundViewExpanded ? 0 : 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.playgroundConfigurationView.isHidden = self.isPlaygroundViewExpanded
        }
    }

}

extension ViewController: PlaygroundViewDelegate {
    func playgroundViewIsExpanded(_ playgroundView: PlaygroundView) -> Bool {
        isPlaygroundViewExpanded
    }

    func playgroundViewDidRequestExpansion(_ playgroundView: PlaygroundView) {
        isPlaygroundViewExpanded = !isPlaygroundViewExpanded
    }
}

extension ViewController: PlaygroundConfigurationViewDelegate {
    func playgroundConfigurationViewWillApplyTopInset(_ playgroundConfigurationView: PlaygroundConfigurationView) -> CGFloat {
        let frame = playgroundConfigurationView.convert(playgroundView.frame, from: view)
        return frame.maxY + .doublePadding - playgroundConfigurationView.safeAreaInsets.top
    }
}
