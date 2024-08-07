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
    private lazy var feedbackGenerator = HapticFeedbackGenerator(style: .light, view: self)

    private let expandButton = UIButton(type: .system)
    private lazy var expandButtonTrailingConstraint = expandButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)


    private lazy var animator = UIDynamicAnimator(referenceView: self)

    private lazy var gravityBehavor: UIGravityBehavior = {
        let behavior = UIGravityBehavior()
        animator.addBehavior(behavior)

        return behavior
    }()

    private lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(behavior)

        return behavior
    }()

    private var interactiveSubviews: Set<UIView> = []

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

    func removeAllInteractiveSubviews() {
        fadeOutAllInteractiveSubviews { _ in
            self.interactiveSubviews.forEach {
                $0.removeFromSuperview()
                self.removeDynamics(from: $0)
            }

            self.interactiveSubviews = []
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
            expandButtonTrailingConstraint
        ])
    }

    // MARK: Dynamics

    private func createInteractiveSubview(at viewCenterPoint: CGPoint) {
        let viewDimension = CGFloat.random(in: 20 ..< 100) // TODO: change with slider
        let viewOrigin = CGPoint(x: viewCenterPoint.x - viewDimension / 2, y: viewCenterPoint.y - viewDimension / 2)
        let viewFrame = CGRect(origin: viewOrigin, size: CGSize(width: viewDimension, height: viewDimension))

        let interactiveSubview = UIView()
        interactiveSubview.frame = viewFrame
        interactiveSubview.backgroundColor = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemGreen, UIColor.systemMint].randomElement()

        addSubview(interactiveSubview)
        interactiveSubviews.insert(interactiveSubview)
        addDynamics(to: interactiveSubview)
    }

    private func addDynamics(to subview: UIView) {
        collisionBehavior.addItem(subview)
        gravityBehavor.addItem(subview)
    }

    private func removeDynamics(from subview: UIView) {
        collisionBehavior.removeItem(subview)
        gravityBehavor.removeItem(subview)
    }

    private func fadeOutAllInteractiveSubviews(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.interactiveSubviews.forEach { $0.alpha = 0 }
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
