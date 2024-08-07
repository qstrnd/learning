//
//  PlaygroundConfigurationViewModel.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-06.
//

import Combine
import UIKit

protocol PlaygroundConfigurationItemFactory {
    func createContentItems() -> [PlaygroundConfigurationView.ContentItem]
}

extension PlaygroundConfigurationView {
    enum SectionItem {
        case singleSection
    }

    struct ContentItem: Hashable, Identifiable {
        let id: String
        let title: String
        let variant: Variant

        enum Variant {
            case toggle(Bool)
            case button
            case stepper(Int)
            case text(String)
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        static func ==(lhs: ContentItem, rhs: ContentItem) -> Bool {
            lhs.id == rhs.id
        }
    }

    final class ViewModel {
        lazy var content = _content.eraseToAnyPublisher()
        private let _content = CurrentValueSubject<[ContentItem], Never>([])

        init(contentFactory: PlaygroundConfigurationItemFactory) {
            self._content.value = contentFactory.createContentItems()
        }
    }

    final class DataSource {
        private unowned var viewModel: ViewModel
        private var diffableDataSource: UICollectionViewDiffableDataSource<SectionItem, ContentItem>?
        private var cancellables: Set<AnyCancellable> = []

        init(viewModel: ViewModel) {
            self.viewModel = viewModel
        }

        func setup(with collectionView: UICollectionView) {
            guard diffableDataSource == nil else {
                assertionFailure("DataSource was already configured")
                return
            }

            let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ContentItem> { cell, _, contentItem in
                var content = cell.defaultContentConfiguration()
                content.text = contentItem.title

                var background = cell.defaultBackgroundConfiguration()
                background.backgroundColorTransformer = UIConfigurationColorTransformer { _ in .clear }

                cell.contentConfiguration = content
                cell.backgroundConfiguration = background
            }

            let diffableDataSource = UICollectionViewDiffableDataSource<SectionItem, ContentItem>(collectionView: collectionView) { collectionView, indexPath, contentItem in
                collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: contentItem)
            }

            collectionView.dataSource = diffableDataSource
            self.diffableDataSource = diffableDataSource

            viewModel.content
                .sink { [unowned self] updatedItems in
                    self.updateSnapshot(with: updatedItems)
                }
                .store(in: &cancellables)
        }

        private func updateSnapshot(with content: [ContentItem]) {
            var snapshot = NSDiffableDataSourceSnapshot<SectionItem, ContentItem>()
            snapshot.appendSections([SectionItem.singleSection])
            snapshot.appendItems(content)
            diffableDataSource?.apply(snapshot)
        }
    }
}
