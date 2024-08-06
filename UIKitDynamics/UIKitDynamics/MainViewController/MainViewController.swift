//
//  MainViewController.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-07-23.
//

import UIKit

final class MainViewController: UIViewController {

    private lazy var layoutManager = PortraitLayoutManager(parentView: view, playgroundView: playgroundView, playgroundConfigurationView: playgroundConfigurationView)

    private let playgroundView = PlaygroundView()

    private var isPlaygroundViewExpanded = false {
        didSet {
            updatePlaygroundViewConstraints(animated: true)
            updateHidableContent(hide: isPlaygroundViewExpanded, animated: true)
        }
    }

    private let playgroundConfigurationView = PlaygroundConfigurationView(viewModel: .init(contentFactory:  DefaultPlaygroundConfigurationItemFactory()))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupPlaygroundConfigurationView()
        setupPlaygroundView()
    }

    private func setupLayout() {
        view.addSubview(playgroundConfigurationView)
        view.addSubview(playgroundView)

        layoutManager.setupInitialConstraints(isExpanded: isPlaygroundViewExpanded)
    }

    private func setupPlaygroundView() {
        playgroundView.delegate = self
    }

    private func updatePlaygroundViewConstraints(animated: Bool = false) {
        layoutManager.updateConstraints(isExpanded: isPlaygroundViewExpanded)

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

extension MainViewController: PlaygroundViewDelegate {
    func playgroundViewIsExpanded(_ playgroundView: PlaygroundView) -> Bool {
        isPlaygroundViewExpanded
    }

    func playgroundViewDidRequestExpansion(_ playgroundView: PlaygroundView) {
        isPlaygroundViewExpanded = !isPlaygroundViewExpanded
    }
}

extension MainViewController: PlaygroundConfigurationViewDelegate {
    func playgroundConfigurationViewWillApplyTopInset(_ playgroundConfigurationView: PlaygroundConfigurationView) -> CGFloat {
        let frame = playgroundConfigurationView.convert(playgroundView.frame, from: view)
        return frame.maxY + .doublePadding - playgroundConfigurationView.safeAreaInsets.top
    }
}
