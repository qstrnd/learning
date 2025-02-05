// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import UIKit

protocol FeedbackGenerator: AnyObject {
    func triggerFeedback()
    func triggerFeedback(at point: CGPoint?)
}

final class HapticFeedbackGenerator: FeedbackGenerator {
    static let sharedLight = HapticFeedbackGenerator(style: .light)
    static let sharedMedium = HapticFeedbackGenerator(style: .medium)
    static let sharedHeavy = HapticFeedbackGenerator(style: .heavy)
    static let sharedSoft = HapticFeedbackGenerator(style: .soft)
    static let sharedRigid = HapticFeedbackGenerator(style: .rigid)

    private let feedbackGenerator: UIImpactFeedbackGenerator

    init(style: UIImpactFeedbackGenerator.FeedbackStyle, view: UIView? = nil) {
        if let view {
            self.feedbackGenerator = UIImpactFeedbackGenerator(style: style, view: view)
        } else {
            self.feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        }
    }

    func triggerFeedback() {
        triggerFeedback(at: nil)
    }

    func triggerFeedback(at point: CGPoint?) {
        feedbackGenerator.prepare()

        if let point {
            feedbackGenerator.impactOccurred(at: point)
        } else {
            feedbackGenerator.impactOccurred()
        }
    }
}
