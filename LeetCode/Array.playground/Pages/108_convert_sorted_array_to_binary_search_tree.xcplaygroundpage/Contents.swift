// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(
        _ val: Int = 0,
        _ left: TreeNode? = nil,
        _ right: TreeNode? = nil
    ) {
        self.val = val
        self.left = left
        self.right = right
    }

    func asArray() -> [Int?] {
        var result: [Int?] = []
        var queue: [TreeNode?] = [self]

        while !queue.isEmpty {
            let node = queue.removeFirst()
            if let node {
                result.append(node.val)
                queue.append(node.left)
                queue.append(node.right)
            } else {
                result.append(nil)
            }
        }

        // Remove trailing `nil` values to represent the array properly
        while let optionalElement = result.last, optionalElement == nil {
            result.removeLast()
        }

        return result
    }
}

final class Solution {
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.isEmpty { return nil }

        return formSubtree(nums: nums, arrayLeftIndex: 0, arrayRightIndex: nums.count - 1)
    }

    private func formSubtree(
        nums: [Int],
        arrayLeftIndex: Int,
        arrayRightIndex: Int
    ) -> TreeNode? {
        guard arrayLeftIndex <= arrayRightIndex else { return nil }

        let anchorIndex = arrayLeftIndex + (arrayRightIndex - arrayLeftIndex) / 2
        let anchorElement = nums[anchorIndex]
        let tree = TreeNode(anchorElement)

        tree.left = formSubtree(nums: nums, arrayLeftIndex: arrayLeftIndex, arrayRightIndex: anchorIndex - 1)
        tree.right = formSubtree(nums: nums, arrayLeftIndex: anchorIndex + 1, arrayRightIndex: arrayRightIndex)

        return tree
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    let test1Nums = [-10, -3, 0, 5, 9]
    let test1Result = solution.sortedArrayToBST(test1Nums)?.asArray()
    assert(
        test1Result == [Optional(0), Optional(-10), Optional(5), nil, Optional(-3), nil, Optional(9)],
        "Incorrectly constructed BST"
    )
    print("Test passed for nums: \(test1Nums) with result: \(test1Result ?? [])")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
