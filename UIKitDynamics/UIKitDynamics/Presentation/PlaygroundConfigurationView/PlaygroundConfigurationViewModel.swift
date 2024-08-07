//
//  PlaygroundConfigurationViewModel.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-06.
//

import Combine
import UIKit

extension PlaygroundConfigurationView {
    enum SectionItem {
        case singleSection
    }

    enum ContentItem: String, Identifiable {
        case clearInteractiveViewsButton
        case useMotionForGravitySwitch

        var id: String {
            rawValue
        }
    }

    final class ViewModel {
        lazy var content = _content.eraseToAnyPublisher()
        private let _content = CurrentValueSubject<[ContentItem], Never>([])
        private let interactiveObjectsService: InteractiveObjectsObserving

        static var initialContentItems: [ContentItem] = [.useMotionForGravitySwitch]

        private var cancellables: Set<AnyCancellable> = []

        init(interactiveObjectsService: InteractiveObjectsObserving) {
            self._content.value = Self.initialContentItems
            self.interactiveObjectsService = interactiveObjectsService

            interactiveObjectsService.count
                .map { $0 > 0 }
                .removeDuplicates()
                .sink { [unowned self] countIsNotEmpty  in
                    if countIsNotEmpty {
                        self._content.value = [.clearInteractiveViewsButton] + Self.initialContentItems
                    } else {
                        self._content.value = Self.initialContentItems
                    }
                }
                .store(in: &cancellables)
        }

        func getConfigurationModel(for item: ContentItem) -> CellConfigurationModel {
            switch item {
            case .clearInteractiveViewsButton:
                return .button(.init(title: "Clear", image: UIImage(systemName: "trash.circle.fill"), onTap: { [weak self] in
                    self?.clearAllInteractiveViews()
                }))
            case .useMotionForGravitySwitch:
                return .switch(.init(isOn: false, onUpdate: { [weak self] newValue in
                    self?.updateMotionEnabled(to: newValue)
                }))
            }
        }

        private func updateMotionEnabled(to newValue: Bool) {

        }

        private func clearAllInteractiveViews() {
            interactiveObjectsService.requestAllItemsRemoval()
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

            let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ContentItem> { [unowned self] cell, _, contentItem in

                let configurationModel = viewModel.getConfigurationModel(for: contentItem)
                let contentConfiguration: UIContentConfiguration
                switch configurationModel {
                case let .button(model):
                    contentConfiguration = self.getButtonConfiguration(for: cell, model: model)
                case let .text(model):
                    contentConfiguration = self.getTextConfiguration(for: cell, model: model)
                case let .switch(model):
                    contentConfiguration = self.getSwitchConfiguration(for: cell, model: model)
                }

                cell.contentConfiguration = contentConfiguration
                cell.backgroundConfiguration = getBackgroundConfiguration(for: cell)
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

        private func getButtonConfiguration(for cell: UICollectionViewListCell, model: CellConfigurationModel.Button) -> UIContentConfiguration {
            var buttonConfiguration = UIButton.Configuration.tinted()
            buttonConfiguration.title = model.title
            buttonConfiguration.cornerStyle = .capsule

            if let image = model.image {
                buttonConfiguration.image = image
                buttonConfiguration.imagePadding = 8
                buttonConfiguration.imagePlacement = .leading
            }

            let content = ButtonCellConfiguration(buttonConfiguration: buttonConfiguration, onButtonTap: model.onTap)

            return content
        }

        private func getSwitchConfiguration(for cell: UICollectionViewListCell, model: CellConfigurationModel.Switch) -> UIContentConfiguration {
            var content = cell.defaultContentConfiguration()

            // TODO: Configure

            return content
        }

        private func getTextConfiguration(for cell: UICollectionViewListCell, model: CellConfigurationModel.Text) -> UIContentConfiguration {
            var content = cell.defaultContentConfiguration()
            content.text = model.title
            content.secondaryText = model.subtitle

            return content
        }

        private func getBackgroundConfiguration(for cell: UICollectionViewCell) -> UIBackgroundConfiguration {
            var background = cell.defaultBackgroundConfiguration()
            background.backgroundColorTransformer = UIConfigurationColorTransformer { _ in .clear }

            return background
        }
    }
}
