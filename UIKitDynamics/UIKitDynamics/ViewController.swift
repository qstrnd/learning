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
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
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
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        } else {
            view.setNeedsLayout()
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
