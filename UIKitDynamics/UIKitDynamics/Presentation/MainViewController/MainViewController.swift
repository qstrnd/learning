//
//  MainViewController.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-07-23.
//

import UIKit

final class MainViewController: UIViewController {

    private let interactiveObjectsManager = InteractiveObjectsManager()

    private lazy var layoutManager = LayoutManager(
        isPlaygroundViewExpanded: false,
        parentView: view,
        playgroundView: playgroundView,
        playgroundConfigurationView: playgroundConfigurationView
    )

    private lazy var playgroundView = PlaygroundView(viewModel: .init(interactiveObjectsManager: interactiveObjectsManager))

    private var isPlaygroundViewExpanded: Bool {
        get {
            layoutManager.isPlaygroundViewExpanded
        }
        set {
            guard newValue != isPlaygroundViewExpanded else { return }

            layoutManager.isPlaygroundViewExpanded = newValue
            updateHidableContent(hide: isPlaygroundViewExpanded, animated: true)
        }
    }

    private lazy var playgroundConfigurationView = PlaygroundConfigurationView(
        viewModel: .init(
            contentFactory:  DefaultPlaygroundConfigurationItemFactory(),
            interactiveObjectsService: interactiveObjectsManager
        )
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupPlaygroundConfigurationView()
        setupPlaygroundView()
    }

    private func setupView() {
        view.backgroundColor = .secondarySystemBackground

        layoutManager.setup()
    }

    private func setupPlaygroundView() {
        playgroundView.delegate = self
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
