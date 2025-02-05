// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Combine
import UIKit

final class ColorSelectionConfiguration: NSObject, UIContentConfiguration {
    struct ColorItem: Hashable {
        let color: UIColor
    }

    let items: [ColorItem]
    let selectedItems: CurrentValueSubject<Set<ColorItem>, Never>

    private var dataSource: UICollectionViewDiffableDataSource<Int, ColorItem>?

    init(items: [ColorItem], selectedItems: CurrentValueSubject<Set<ColorItem>, Never>) {
        self.items = items
        self.selectedItems = selectedItems
    }

    func makeContentView() -> UIView & UIContentView {
        ColorSelectionContentView(configuration: self)
    }

    func updated(for _: UIConfigurationState) -> Self {
        self
    }

    func setup(collectionView: UICollectionView) {
        let layout = createCollectionViewCompositionalLayout()
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.allowsMultipleSelection = true

        dataSource = createCollectionViewDataSource(collectionView: collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self

        var snapshot = NSDiffableDataSourceSnapshot<Int, ColorItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }

    private func createCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalHeight(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 2, leading: 16, bottom: 6, trailing: 16)
        section.interGroupSpacing = 8

        let configuration = createCollectionViewConfiguration()
        return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
    }

    private func createCollectionViewConfiguration() -> UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal

        return configuration
    }

    private func createCollectionViewDataSource(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Int, ColorItem> {
        let cellRegistration = UICollectionView.CellRegistration<ColorItemCell, ColorItem> { [unowned self] cell, _, item in
            cell.configure(color: item.color, isSelected: self.selectedItems.value.contains(item))
        }

        let diffableDataSource = UICollectionViewDiffableDataSource<Int, ColorItem>(collectionView: collectionView) { collectionView, indexPath, contentItem in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: contentItem)
        }

        return diffableDataSource
    }
}

// MARK: - UICollectionViewDelegate

extension ColorSelectionConfiguration: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateSelection(for: indexPath, in: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateSelection(for: indexPath, in: collectionView)
    }

    private func updateSelection(for indexPath: IndexPath, in collectionView: UICollectionView) {
        let item = items[indexPath.item]

        let isSelected: Bool
        var updatedSelectedValues = selectedItems.value
        if updatedSelectedValues.contains(item) {
            if updatedSelectedValues.count == 1 { return }
            updatedSelectedValues.remove(item)
            isSelected = false
        } else {
            updatedSelectedValues.insert(item)
            isSelected = true
        }
        selectedItems.value = updatedSelectedValues

        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorItemCell else { return }
        cell.updateWithAnimation(isSelected: isSelected)
    }
}
