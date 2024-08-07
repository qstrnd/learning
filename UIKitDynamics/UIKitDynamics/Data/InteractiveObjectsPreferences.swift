//
//  InteractiveObjectsPreferences.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-08.
//

import UIKit

protocol InteractiveObjectsPreferencesKeeping: AnyObject {
    var minDimension: CGFloat { get set }
    var maxDimension: CGFloat { get set }
    var colors: [UIColor] { get set }
    var minPossibleDimension: CGFloat { get }
    var maxPossibleDimension: CGFloat { get }
}

protocol InteractiveObjectsPreferencesProvider {
    func getRandomDimension() -> CGFloat
    func getRandomColor() -> UIColor
}

final class InteractiveObjectsPreferencesManager: InteractiveObjectsPreferencesKeeping, InteractiveObjectsPreferencesProvider {
    lazy var minDimension: CGFloat = minPossibleDimension
    lazy var maxDimension: CGFloat = maxPossibleDimension
    var colors: [UIColor] =  [UIColor.systemRed, UIColor.systemBlue, UIColor.systemGreen, UIColor.systemMint]

    let minPossibleDimension: CGFloat = 20
    let maxPossibleDimension: CGFloat = 120

    func getRandomDimension() -> CGFloat {
        CGFloat.random(in: minDimension ..< maxDimension)
    }

    func getRandomColor() -> UIColor {
        colors.randomElement() ?? .systemBlue
    }
}
