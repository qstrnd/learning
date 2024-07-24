//
//  PlaygroundView.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-07-24.
//

import UIKit

protocol PlaygroundViewDelegate: AnyObject {
    func playgroundViewDidRequestExpansion(_ playgroundView: PlaygroundView)
    func playgroundViewIsExpanded(_ playgroundView: PlaygroundView) -> Bool
}

final class PlaygroundView: UIView {

    weak var delegate: PlaygroundViewDelegate?

    private let expandButton = UIButton(type: .system)
    private lazy var expandButtonTrailingConstraint = expandButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)

    // MARK: - Methods

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
    }

    // MARK: Setup

    private func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = .standardCornerRadius
        layer.masksToBounds = false
        
        setupShadow()
        setupExpandButton()
    }

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5
    }

    // MARK: Expand Button

    private func setupExpandButton() {
        expandButton.tintColor = .tertiaryLabel
        expandButton.addTarget(self, action: #selector(handleExpandButtonTap), for: .touchUpInside)
        layoutExpandButton()
        updateExpandButton()
    }

    private func updateExpandButton() {
        let isExpanded = delegate?.playgroundViewIsExpanded(self) ?? false
        let imageName = isExpanded ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right"
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        expandButton.setImage(image, for: .normal)

        let trailingPadding: CGFloat = isExpanded ? .doublePadding : .standardPadding
        expandButtonTrailingConstraint.constant = -trailingPadding
    }

    private func shimmerExpandButton() {
        expandButton.alpha = 0

        UIView.animate(withDuration: 0.8) {
            self.expandButton.alpha = 1
        }
    }

    private func layoutExpandButton() {
        addSubview(expandButton)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            expandButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .standardPadding),
            expandButtonTrailingConstraint
        ])
    }

    // MARK: Actions

    @objc private func handleExpandButtonTap() {
        delegate?.playgroundViewDidRequestExpansion(self)
        updateExpandButton()
        shimmerExpandButton()
    }
}
