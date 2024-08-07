//
//  PlaygroundConfigurationView.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-06.
//

import UIKit

protocol PlaygroundConfigurationViewDelegate: AnyObject {
    func playgroundConfigurationViewWillApplyTopInset(_ playgroundConfigurationView: PlaygroundConfigurationView) -> CGFloat
}

final class PlaygroundConfigurationView: UIView {
    weak var delegate: PlaygroundConfigurationViewDelegate?

    private let viewModel: ViewModel
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let dataSource: DataSource

    init(frame: CGRect = .zero, viewModel: ViewModel) {
        self.viewModel = viewModel
        self.dataSource = DataSource(viewModel: viewModel)
        super.init(frame: frame)

        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        collectionView.frame = bounds

        updateTopInset()
    }

    private func setupCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .secondarySystemBackground
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.setCollectionViewLayout(layout, animated: false)
        dataSource.setup(with: collectionView)

        addSubview(collectionView)
    }

    private func updateTopInset() {
        var updatedInset = collectionView.contentInset
        updatedInset.top = delegate?.playgroundConfigurationViewWillApplyTopInset(self) ?? .zero
        collectionView.contentInset = updatedInset
    }
}
