//
//  InteractiveObjectsPreferences.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-08.
//

import Combine
import UIKit

protocol InteractiveObjectsPreferencesKeeping: AnyObject {
    var isRandomizationEnabled: CurrentValueSubject<Bool, Never> { get }
    var minDimension: CGFloat { get set }
    var maxDimension: CGFloat { get set }
    var colors: [UIColor] { get set }
    var possibleColors: [UIColor] { get set }
    var minPossibleDimension: CGFloat { get }
    var maxPossibleDimension: CGFloat { get }
}

protocol InteractiveObjectsPreferencesProvider {
    func getDimension() -> CGFloat
    func getColor() -> UIColor
}

final class InteractiveObjectsPreferencesManager: InteractiveObjectsPreferencesKeeping, InteractiveObjectsPreferencesProvider {
    lazy var minDimension: CGFloat = minPossibleDimension
    lazy var maxDimension: CGFloat = maxPossibleDimension

    var possibleColors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemMint, .systemCyan, .systemBlue, .systemPurple]
    var colors: [UIColor]

    let minPossibleDimension: CGFloat = 20
    let maxPossibleDimension: CGFloat = 120

    var isRandomizationEnabled: CurrentValueSubject<Bool, Never> = .init(true)

    init() {
        colors = possibleColors
    }

    func getDimension() -> CGFloat {
        guard isRandomizationEnabled.value else {
            return 64
        }

        let roundedMin = minDimension.rounded()
        let roundedMax = maxDimension.rounded()

        guard roundedMin != roundedMax else {
            return roundedMax
        }

        let dimension = CGFloat.random(in: roundedMin ..< roundedMax)
        return dimension
    }

    func getColor() -> UIColor {
        guard isRandomizationEnabled.value else {
            return .systemGray
        }

        return colors.randomElement() ?? .systemBlue
    }

}
