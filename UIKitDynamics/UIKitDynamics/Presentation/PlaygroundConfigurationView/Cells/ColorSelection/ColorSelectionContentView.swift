// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Combine
import CombineCocoa
import UIKit

final class ColorSelectionContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            self.applyCurrentConfiguration()
        }
    }

    private var cancellables: Set<AnyCancellable> = []

    private let nestedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)

        setupView()
        setupLayout()
        applyCurrentConfiguration()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        nestedCollectionView.backgroundColor = nil
        nestedCollectionView.showsHorizontalScrollIndicator = false
    }

    private func setupLayout() {
        addSubview(nestedCollectionView)

        nestedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nestedCollectionView.topAnchor.constraint(equalTo: topAnchor),
            nestedCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nestedCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nestedCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nestedCollectionView.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    private func applyCurrentConfiguration() {
        guard let configuration = self.configuration as? ColorSelectionConfiguration else { return }

        configuration.setup(collectionView: nestedCollectionView)
    }
}
