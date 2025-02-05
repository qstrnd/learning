// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import UIKit

final class MainViewController: UIViewController {
    private let interactiveObjectsManager = InteractiveObjectsManager()
    private let preferencesManager = InteractiveObjectsPreferencesManager()

    private lazy var layoutManager = LayoutManager(
        isPlaygroundViewExpanded: false,
        parentView: view,
        playgroundView: playgroundView,
        playgroundConfigurationView: playgroundConfigurationView
    )

    private lazy var playgroundView = PlaygroundView(
        viewModel: .init(
            interactiveObjectsManager: interactiveObjectsManager,
            preferencesProvider: preferencesManager
        )
    )

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
            interactiveObjectsService: interactiveObjectsManager,
            interactivePreferencesService: preferencesManager
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
    func playgroundViewIsExpanded(_: PlaygroundView) -> Bool {
        isPlaygroundViewExpanded
    }

    func playgroundViewDidRequestExpansion(_: PlaygroundView) {
        isPlaygroundViewExpanded = !isPlaygroundViewExpanded
    }
}

extension MainViewController: PlaygroundConfigurationViewDelegate {
    func playgroundConfigurationViewWillApplyTopInset(_: PlaygroundConfigurationView) -> CGFloat {
        layoutManager.calculateTopInsetForPlaygroundConfigurationViewContent()
    }
}
