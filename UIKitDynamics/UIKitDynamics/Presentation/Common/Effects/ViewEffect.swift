//
//  ViewEffect.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-07.
//

import UIKit

protocol ViewEffect {
    func apply(to view: UIView)
}

extension UIView {
    func apply(effect: ViewEffect) {
        effect.apply(to: self)
    }
}
