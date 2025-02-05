// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Combine
import UIKit

protocol PlaygroundViewDelegate: AnyObject {
    func playgroundViewDidRequestExpansion(_ playgroundView: PlaygroundView)
    func playgroundViewIsExpanded(_ playgroundView: PlaygroundView) -> Bool
}

final class PlaygroundView: UIView {
    weak var delegate: PlaygroundViewDelegate?
    private lazy var feedbackGenerator = HapticFeedbackGenerator(style: .light, view: self)

    private let expandButton = UIButton(type: .system)
    private lazy var expandButtonTrailingConstraint = expandButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)

    private let viewModel: ViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Methods

    init(viewModel: ViewModel, frame: CGRect = .zero) {
        self.viewModel = viewModel
        super.init(frame: frame)
        viewModel.view = self

        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func removeAllInteractiveSubviews() {
        fadeOutAllInteractiveSubviews { _ in
            self.viewModel
                .removeAllInteractiveSubviews()
                .forEach { $0.removeFromSuperview() }
        }
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
        setupGestures()
        setupObservers()

        // TODO: Register for orientation change and remove the views outside bounds
    }

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5
    }

    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAction(tap:)))
        addGestureRecognizer(tap)
    }

    private func setupObservers() {
        viewModel.removeAllItemsPublisher
            .sink { [weak self] _ in
                self?.removeAllInteractiveSubviews()
            }
            .store(in: &cancellables)
    }

    @objc
    private func handleTapAction(tap: UITapGestureRecognizer) {
        let tapLocation = tap.location(in: self)

        let effect = RippleEffect(startingPoint: tapLocation, feedbackGenerator: feedbackGenerator)
        apply(effect: effect)

        createInteractiveSubview(at: tapLocation)
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
            expandButtonTrailingConstraint,
        ])
    }

    // MARK: Dynamics

    private func createInteractiveSubview(at viewCenterPoint: CGPoint) {
        let viewDimension = viewModel.preferencesProvider.getDimension()
        let viewOrigin = CGPoint(x: viewCenterPoint.x - viewDimension / 2, y: viewCenterPoint.y - viewDimension / 2)
        let viewFrame = CGRect(origin: viewOrigin, size: CGSize(width: viewDimension, height: viewDimension))

        let interactiveSubview = UIView()
        interactiveSubview.frame = viewFrame
        interactiveSubview.backgroundColor = viewModel.preferencesProvider.getColor()

        addSubview(interactiveSubview)
        viewModel.registerInteractiveSubview(interactiveSubview)
    }

    private func fadeOutAllInteractiveSubviews(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.viewModel.interactiveSubviews.forEach { $0.alpha = 0 }
        }, completion: completion)
    }

    // MARK: Actions

    @objc private func handleExpandButtonTap() {
        delegate?.playgroundViewDidRequestExpansion(self)
        updateExpandButton()
        shimmerExpandButton()

        if !(delegate?.playgroundViewIsExpanded(self) ?? false) {
            removeAllInteractiveSubviews()
        }
    }
}
