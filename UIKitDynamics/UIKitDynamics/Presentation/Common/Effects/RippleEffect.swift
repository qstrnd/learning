// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import UIKit

struct RippleEffect: ViewEffect {
    let startingPoint: CGPoint
    let color: UIColor
    let growthDuration: TimeInterval
    let fadeOutDuration: TimeInterval
    let feedbackGenerator: HapticFeedbackGenerator?

    init(
        startingPoint: CGPoint,
        color: UIColor = .placeholderText,
        growthDuration: TimeInterval = 0.5,
        fadeOutDuration: TimeInterval = 0.4,
        feedbackGenerator: HapticFeedbackGenerator? = nil
    ) {
        self.startingPoint = startingPoint
        self.color = color
        self.growthDuration = growthDuration
        self.fadeOutDuration = fadeOutDuration
        self.feedbackGenerator = feedbackGenerator
    }

    func apply(to view: UIView) {
        performFeedback()
        performAnimation(in: view)
    }

    private func performFeedback() {
        feedbackGenerator?.triggerFeedback(at: startingPoint)
    }

    private func performAnimation(in view: UIView) {
        let rippleLayer = CAShapeLayer()
        let maxDimension = max(view.frame.width, view.frame.height)
        rippleLayer.opacity = 0 // final state
        rippleLayer.fillColor = color.cgColor
        rippleLayer.frame = CGRect(x: startingPoint.x - maxDimension / 2, y: startingPoint.y - maxDimension / 2, width: maxDimension, height: maxDimension)
        rippleLayer.path = UIBezierPath(ovalIn: rippleLayer.bounds).cgPath

        let growthAnimation = CABasicAnimation(keyPath: "transform.scale")
        growthAnimation.fromValue = 0
        growthAnimation.toValue = 1
        growthAnimation.duration = growthDuration
        growthAnimation.isRemovedOnCompletion = false

        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 1.0
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = fadeOutDuration
        fadeOutAnimation.isRemovedOnCompletion = false

        let totalDuration = max(growthDuration, fadeOutDuration)
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = totalDuration
        animationGroup.animations = [growthAnimation, fadeOutAnimation]

        let contentLayer = getConfiguredContentLayer(for: view)
        contentLayer.addSublayer(rippleLayer)
        rippleLayer.add(animationGroup, forKey: "rippleEffect")

        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) {
            rippleLayer.removeFromSuperlayer()
        }
    }

    private func getConfiguredContentLayer(for view: UIView) -> CALayer {
        let contentLayer: CALayer
        if let existingContentLayer = view.existingContentLayer {
            contentLayer = existingContentLayer
        } else {
            let maskLayer = CAShapeLayer()

            contentLayer = CALayer()
            contentLayer.mask = maskLayer

            view.layer.insertSublayer(contentLayer, at: 0)

            view.existingContentLayer = contentLayer
        }

        if contentLayer.frame != view.bounds {
            contentLayer.frame = view.bounds
            (contentLayer.mask as? CAShapeLayer)?.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
        }

        return contentLayer
    }
}

private extension UIView {
    static var existingContentLayerKey: UInt8 = 0

    var existingContentLayer: CALayer? {
        get {
            objc_getAssociatedObject(self, &Self.existingContentLayerKey) as? CALayer
        }
        set {
            objc_setAssociatedObject(self, &Self.existingContentLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
