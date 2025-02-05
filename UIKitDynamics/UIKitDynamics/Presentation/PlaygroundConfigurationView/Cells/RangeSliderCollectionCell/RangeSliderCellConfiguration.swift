// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Combine
import UIKit

struct RangeSliderCellConfiguration: UIContentConfiguration {
    let title: String
    let minValue: CGFloat
    let maxValue: CGFloat
    let selectedMinValue: CGFloat
    let selectedMaxValue: CGFloat
    let onValueChanged: PassthroughSubject<(CGFloat, CGFloat), Never>

    func makeContentView() -> UIView & UIContentView {
        RangeSliderCellContentView(configuration: self)
    }

    func updated(for _: UIConfigurationState) -> RangeSliderCellConfiguration {
        self
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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
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
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.standardPadding),
        ])
    }

    private func applyCurrentConfiguration() {
        guard let configuration = self.configuration as? RangeSliderCellConfiguration else { return }

        slider.selectedMinValue = configuration.selectedMinValue
        slider.selectedMaxValue = configuration.selectedMaxValue
        slider.minValue = configuration.minValue
        slider.maxValue = configuration.maxValue

        title.text = configuration.title
    }
}

extension RangeSliderCellContentView: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange _: CGFloat, maxValue _: CGFloat) {
        guard let configuration = self.configuration as? RangeSliderCellConfiguration else { return }

        configuration.onValueChanged.send((slider.selectedMinValue, slider.selectedMaxValue))
    }
}
