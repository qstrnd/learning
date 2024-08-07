//
//  CollectionViewCell.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-07.
//

import UIKit

struct ButtonCellConfiguration: UIContentConfiguration {
    let buttonConfiguration: UIButton.Configuration
    let onButtonTap: () -> Void

    func makeContentView() -> UIView & UIContentView {
        ButtonCellContentView(configuration: self)
    }
    func updated(for state: UIConfigurationState) -> ButtonCellConfiguration {
        return self
    }
}

final class ButtonCellContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            self.applyCurrentConfiguration()
        }
    }

    private let button = UIButton(type: .system)

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)

        setupLayout()
        applyCurrentConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.topAnchor.constraint(equalTo: topAnchor, constant: .standardPadding),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.standardPadding)
        ])

        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }

    private func applyCurrentConfiguration() {
        guard let configuration = self.configuration as? ButtonCellConfiguration else { return }

        button.configuration = configuration.buttonConfiguration
    }

    @objc
    private func handleButtonTap() {
        guard let configuration = self.configuration as? ButtonCellConfiguration else { return }

        configuration.onButtonTap()
    }
}
