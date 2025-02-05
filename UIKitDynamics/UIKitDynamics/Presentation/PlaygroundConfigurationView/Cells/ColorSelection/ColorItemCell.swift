// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import UIKit

final class ColorItemCell: UICollectionViewCell {
    private enum Constants {
        static let innerCircleSide: CGFloat = 8
    }

    private let innerCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.innerCircleSide / 2
        view.isHidden = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.size.width / 2
    }

    func configure(color: UIColor, isSelected: Bool) {
        contentView.backgroundColor = color
        innerCircle.isHidden = !isSelected
    }

    func updateWithAnimation(isSelected: Bool) {
        let initialTransform = isSelected ? CGAffineTransform(scaleX: 0.1, y: 0.1) : .identity
        let finalTransform = isSelected ? .identity : CGAffineTransform(scaleX: 0.1, y: 0.1)

        innerCircle.transform = initialTransform
        innerCircle.isHidden = false

        UIView.animate(withDuration: 0.2) {
            self.innerCircle.transform = finalTransform
        } completion: { _ in
            self.innerCircle.isHidden = !isSelected
        }
    }

    private func setupCell() {
        contentView.layer.masksToBounds = true

        contentView.addSubview(innerCircle)
        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            innerCircle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            innerCircle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            innerCircle.widthAnchor.constraint(equalToConstant: Constants.innerCircleSide),
            innerCircle.heightAnchor.constraint(equalToConstant: Constants.innerCircleSide),
        ])
    }
}
