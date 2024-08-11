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
        case clearInteractiveObjectsButton
        case randomizeObjectsStyleSwitch
        case minMaxInteractiveObjectDimensionSlider

        var id: String {
            rawValue
        }
    }

    final class ViewModel {
        lazy var content = _content.eraseToAnyPublisher()
        private let _content = CurrentValueSubject<[ContentItem], Never>([])

        private let interactiveObjectsService: InteractiveObjectsObserving
        private let interactivePreferencesService: InteractiveObjectsPreferencesKeeping

        private let didTapClearInteractiveObjectsButton = PassthroughSubject<Void, Never>()
        private let didUpdateMinMaxObjectDimensions = PassthroughSubject<(CGFloat, CGFloat), Never>()

        private var cancellables: Set<AnyCancellable> = []

        init(
            interactiveObjectsService: InteractiveObjectsObserving,
            interactivePreferencesService: InteractiveObjectsPreferencesKeeping
        ) {
            self.interactiveObjectsService = interactiveObjectsService
            self.interactivePreferencesService = interactivePreferencesService

            setupBindings()
        }

        private func setupBindings() {
            let isObjectCountEmptyPublisher = interactiveObjectsService.count
                .map { $0 == 0 }
                .removeDuplicates()
                .eraseToAnyPublisher()

            Publishers.CombineLatest(isObjectCountEmptyPublisher, interactivePreferencesService.isRandomizationEnabled)
                .sink { [unowned self] (isObjectCountEmpty, isRandomizedObjectStyleEnabled) in
                    self._content.value = self.buildContentItems(
                        isObjectCountEmpty: isObjectCountEmpty,
                        isRandomizedObjectStyleEnabled: isRandomizedObjectStyleEnabled
                    )
                }
                .store(in: &cancellables)

            didTapClearInteractiveObjectsButton
                .sink { [unowned self] in
                    self.interactiveObjectsService.requestAllItemsRemoval()
                }
                .store(in: &cancellables)

            didUpdateMinMaxObjectDimensions
                .throttle(for: .seconds(0.5), scheduler: DispatchQueue.main, latest: true)
                .sink { [unowned self] (min, max) in
                    self.updateMinMaxDimensions(min: min, max: max)
                }
                .store(in: &cancellables)
        }

        private func buildContentItems(
            isObjectCountEmpty: Bool,
            isRandomizedObjectStyleEnabled: Bool
        ) -> [ContentItem] {
            var items: [ContentItem] = []

            items.append(.randomizeObjectsStyleSwitch)
            if isRandomizedObjectStyleEnabled {
                items.append(.minMaxInteractiveObjectDimensionSlider)
            }

            if !isObjectCountEmpty {
                items.append(.clearInteractiveObjectsButton)
            }

            return items
        }

        func getContentConfiguration(for item: ContentItem, in cell: UICollectionViewListCell) -> UIContentConfiguration {
            switch item {
            case .clearInteractiveObjectsButton:
                return configurationForClearInteractiveObjectsButton()
            case .randomizeObjectsStyleSwitch:
                return configurationForRandomizeObjectsStyleSwitch(for: cell)
            case .minMaxInteractiveObjectDimensionSlider:
                return configurationForMinMaxInteractiveObjectDimensionSlider(for: cell)
            }
        }

        private func configurationForClearInteractiveObjectsButton() -> UIContentConfiguration {
            var buttonConfiguration = getDefaultUIButtonConfiguration()
            buttonConfiguration.title = "Clear"
            buttonConfiguration.image = UIImage(systemName: "trash.circle.fill")

            return ButtonCellConfiguration(
                buttonConfiguration: CurrentValueSubject(buttonConfiguration),
                didTapButton: didTapClearInteractiveObjectsButton
            )
        }

        private func getDefaultUIButtonConfiguration() -> UIButton.Configuration {
            var buttonConfiguration = UIButton.Configuration.tinted()
            buttonConfiguration.cornerStyle = .capsule

            buttonConfiguration.imagePadding = 8
            buttonConfiguration.imagePlacement = .leading

            return buttonConfiguration
        }

        private func configurationForRandomizeObjectsStyleSwitch(for cell: UICollectionViewListCell) -> UIContentConfiguration {
            var cellConfiguration = cell.defaultContentConfiguration()
            cellConfiguration.text = "Randomize objects style"

            let switchView = UISwitch(frame: .zero, primaryAction: .init(handler: { action in
                guard let senderSwitch = action.sender as? UISwitch else { return }
                self.updateRandomizeObjectsStyleEnabled(to: senderSwitch.isOn)
            }))

            switchView.isOn = interactivePreferencesService.isRandomizationEnabled.value

            cell.accessories = [
                .customView(
                    configuration: .init(
                        customView: switchView,
                        placement: .trailing(displayed: .always)
                    )
                )
            ]

            return cellConfiguration
        }

        private func configurationForMinMaxInteractiveObjectDimensionSlider(for cell: UICollectionViewListCell) -> UIContentConfiguration {
            let content = RangeSliderCellConfiguration(
                title: "Dimensions",
                minValue: interactivePreferencesService.minPossibleDimension,
                maxValue: interactivePreferencesService.maxPossibleDimension,
                selectedMinValue: interactivePreferencesService.minDimension,
                selectedMaxValue: interactivePreferencesService.maxDimension,
                onValueChanged: didUpdateMinMaxObjectDimensions
            )

            return content
        }

        private func updateMinMaxDimensions(min: CGFloat, max: CGFloat) {
            interactivePreferencesService.minDimension = min
            interactivePreferencesService.maxDimension = max
        }

        private func updateRandomizeObjectsStyleEnabled(to newValue: Bool) {
            interactivePreferencesService.isRandomizationEnabled.send(newValue)
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
                cell.contentConfiguration = viewModel.getContentConfiguration(for: contentItem, in: cell)
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

        private func getBackgroundConfiguration(for cell: UICollectionViewCell) -> UIBackgroundConfiguration {
            var background = cell.defaultBackgroundConfiguration()
            background.backgroundColorTransformer = UIConfigurationColorTransformer { _ in .clear }

            return background
        }
    }
}
