// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Combine
import CombineCocoa
import UIKit

struct ButtonCellConfiguration: UIContentConfiguration {
    let buttonConfiguration: CurrentValueSubject<UIButton.Configuration, Never>
    let didTapButton: PassthroughSubject<Void, Never>

    init(buttonConfiguration: CurrentValueSubject<UIButton.Configuration, Never>, didTapButton: PassthroughSubject<Void, Never>) {
        self.buttonConfiguration = buttonConfiguration
        self.didTapButton = didTapButton
    }

    func makeContentView() -> UIView & UIContentView {
        ButtonCellContentView(configuration: self)
    }

    func updated(for _: UIConfigurationState) -> Self {
        self
    }
}

final class ButtonCellContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            self.applyCurrentConfiguration()
        }
    }

    private var cancellables: Set<AnyCancellable> = []
    private let button = UIButton(type: .system)

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)

        setupLayout()
        applyCurrentConfiguration()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.topAnchor.constraint(equalTo: topAnchor, constant: .standardPadding),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.standardPadding),
        ])
    }

    private func applyCurrentConfiguration() {
        guard let viewModel = self.configuration as? ButtonCellConfiguration else { return }

        bindViewModel(viewModel)
    }

    private func bindViewModel(_ viewModel: ButtonCellConfiguration) {
        cancellables = []

        button.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                viewModel.didTapButton.send(())
            }
            .store(in: &cancellables)

        viewModel.buttonConfiguration
            .sink { [unowned self] configuration in
                button.configuration = configuration
            }
            .store(in: &cancellables)
    }
}
