// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import UIKit

protocol ViewEffect {
    func apply(to view: UIView)
}

extension UIView {
    func apply(effect: ViewEffect) {
        effect.apply(to: self)
    }
}
