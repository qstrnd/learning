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
    func height(_ root: TreeNode?) -> Int {
        root == nil ? -1 : 1 + height(root?.left)
    }

    func countNodes(_ root: TreeNode?) -> Int {
        let h = height(root)
        if h < 0 {
            return 0
        } else {
            if height(root?.right) == h - 1 {
                return (1 << h) + countNodes(root?.right)
            } else {
                return (1 << h - 1) + countNodes(root?.left)
            }
        }
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    var root = TreeNode(1)
    root.left = TreeNode(2)
    root.left?.left = TreeNode(4)
    root.left?.right = TreeNode(5)
    root.right = TreeNode(3)
    root.right?.left = TreeNode(4)

    assert(solution.countNodes(root) == 6, "Test failed: countNodes([1,2,3,4,5,6])) == 6")
    print("Test passed: countNodes(\(root)) == 6")

    root = TreeNode(1)
    assert(solution.countNodes(root) == 1, "Test failed: countNodes([1]) == 1")
    print("Test passed: countNodes(\(root)) == 1")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
