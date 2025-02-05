// Copyright © 2024 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Combine
import UIKit

protocol InteractiveObjectsManaging: AnyObject {
    var count: AnyPublisher<Int, Never> { get }
    var removeAllItemsPublisher: PassthroughSubject<Void, Never> { get }

    func increaseCount()
    func resetCount()
}

protocol InteractiveObjectsObserving: AnyObject {
    var count: AnyPublisher<Int, Never> { get }

    func requestAllItemsRemoval()
}

final class InteractiveObjectsManager: InteractiveObjectsManaging, InteractiveObjectsObserving {
    var count: AnyPublisher<Int, Never>
    private var _count: CurrentValueSubject<Int, Never>

    var removeAllItemsPublisher = PassthroughSubject<Void, Never>()

    init() {
        self._count = .init(0)
        self.count = _count.eraseToAnyPublisher()
    }

    func increaseCount() {
        _count.value = _count.value + 1
    }

    func resetCount() {
        _count.value = 0
    }

    func requestAllItemsRemoval() {
        removeAllItemsPublisher.send(())
    }
}
