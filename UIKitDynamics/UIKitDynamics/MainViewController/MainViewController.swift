//
//  MainViewController.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-07-23.
//

import UIKit

final class MainViewController: UIViewController {

    private lazy var layoutManager = LayoutManager(
        parentView: view,
        playgroundView: playgroundView,
        playgroundConfigurationView: playgroundConfigurationView
    )

    private let playgroundView = PlaygroundView()

    private var isPlaygroundViewExpanded = false {
        didSet {
            updatePlaygroundViewConstraints(animated: true)
            updateHidableContent(hide: isPlaygroundViewExpanded, animated: true)
        }
    }

    private let playgroundConfigurationView = PlaygroundConfigurationView(viewModel: .init(contentFactory:  DefaultPlaygroundConfigurationItemFactory()))
    
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPlaygroundConfigurationView()
        setupPlaygroundView()
        setupObservers()
    }

    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
    }

    private func setupObservers() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(handleOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc
    private func handleOrientationChange() {
        layoutManager.prepare(for: UIDevice.current.orientation)
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
        layoutManager.calculateTopInsetForPlaygroundConfigurationViewContent()
    }
}
