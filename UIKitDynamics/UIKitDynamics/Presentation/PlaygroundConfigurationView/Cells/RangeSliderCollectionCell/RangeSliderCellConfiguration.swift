//
//  RangeSliderCellConfiguration.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-08.
//

import UIKit

struct RangeSliderCellConfiguration: UIContentConfiguration {
    let title: String
    let minValue: Float
    let maxValue: Float
    let selectedMinValue: Float
    let selectedMaxValue: Float
    let onValueChanged: (_ min: Float, _ max: Float) -> Void

    func makeContentView() -> UIView & UIContentView {
        RangeSliderCellContentView(configuration: self)
    }
    func updated(for state: UIConfigurationState) -> RangeSliderCellConfiguration {
        return self
    }
}

final class RangeSliderCellContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            self.applyCurrentConfiguration()
        }
    }

    private let title = UILabel()
    private let slider = RangeSeekSlider()

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)

        setupViews()
        setupLayout()
        applyCurrentConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        slider.delegate = self
    }

    private func setupLayout() {
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)

        slider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(slider)

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.standardPadding),
            title.topAnchor.constraint(equalTo: topAnchor, constant: .standardPadding),

            slider.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -.standardPadding),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.standardPadding),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .standardPadding),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.standardPadding)
        ])
    }

    private func applyCurrentConfiguration() {
        guard let configuration = self.configuration as? RangeSliderCellConfiguration else { return }

        slider.selectedMinValue = CGFloat(configuration.selectedMinValue)
        slider.selectedMaxValue = CGFloat(configuration.selectedMaxValue)
        slider.minValue = CGFloat(configuration.minValue)
        slider.maxValue = CGFloat(configuration.maxValue)

        title.text = configuration.title
    }
}

extension RangeSliderCellContentView: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        guard let configuration = self.configuration as? RangeSliderCellConfiguration else { return }

        configuration.onValueChanged(Float(slider.selectedMinValue), Float(slider.selectedMaxValue))
    }
}
