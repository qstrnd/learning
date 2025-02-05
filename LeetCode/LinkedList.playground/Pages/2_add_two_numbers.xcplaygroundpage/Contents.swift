// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class ListNode {
    var val: Int
    var next: ListNode?

    init(
        _ val: Int = 0,
        _ next: ListNode? = nil
    ) {
        self.val = val; self.next = next
    }

    func asArray() -> [Int] {
        var result: [Int] = []

        var node: ListNode? = self
        while node != nil {
            guard let value = node?.val else { continue }
            result.append(value)
            node = node?.next
        }

        return result
    }
}

final class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var carry = 0
        var result: ListNode?
        var current = result
        var l1 = l1
        var l2 = l2

        while l1 != nil || l2 != nil || carry != 0 {
            let l1Val = l1?.val ?? 0
            let l2Val = l2?.val ?? 0
            let sum = l1Val + l2Val + carry
            let digit = sum % 10
            carry = sum / 10

            let next = ListNode(digit)
            if current == nil {
                current = next
                result = current
            } else {
                current?.next = next
                current = next
            }

            l1 = l1?.next
            l2 = l2?.next
        }

        return result ?? ListNode(0)
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    var l1 = ListNode(
        2, ListNode(
            4, ListNode(
                3, nil
            )
        )
    )

    var l2 = ListNode(
        5, ListNode(
            6, ListNode(
                4, nil
            )
        )
    )

    var testResult = solution.addTwoNumbers(l1, l2)?.asArray() ?? []
    assert(
        testResult == [7, 0, 8], "Test failed: addTwoNumbers([2,4,3],[5,6,4]) == [7,0,8]"
    )
    print("Test passed: addTwoNumbers([2,4,3],[5,6,4]) == [7,0,8]")

    l1 = ListNode(
        9, ListNode(
            9, ListNode(
                9, ListNode(
                    9, ListNode(
                        9, ListNode(
                            9, ListNode(
                                9, nil
                            )
                        )
                    )
                )
            )
        )
    )

    l2 = ListNode(
        9, ListNode(
            9, ListNode(
                9, ListNode(
                    9, nil
                )
            )
        )
    )

    testResult = solution.addTwoNumbers(l1, l2)?.asArray() ?? []
    assert(
        testResult == [8, 9, 9, 9, 0, 0, 0, 1], "Test failed: addTwoNumbers([9,9,9,9,9,9,9],[9,9,9,9]) == [8,9,9,9,0,0,0,1]"
    )
    print("Test passed: addTwoNumbers([9,9,9,9,9,9,9],[9,9,9,9]) == [8,9,9,9,0,0,0,1]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
