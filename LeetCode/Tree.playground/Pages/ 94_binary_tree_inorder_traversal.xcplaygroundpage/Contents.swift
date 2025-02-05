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

protocol Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int]
}

final class Solution_Recursive: Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result: [Int] = []
        traverse(root, result: &result)
        return result
    }

    private func traverse(_ node: TreeNode?, result: inout [Int]) {
        guard let node else { return }
        traverse(node.left, result: &result)
        result.append(node.val)
        traverse(node.right, result: &result)
    }
}

final class Solution_Loop: Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var stack: [TreeNode] = []
        var result: [Int] = []
        var current = root

        while current != nil || !stack.isEmpty {
            while let c = current {
                stack.append(c)
                current = c.left
            }

            let c = stack.removeLast()
            result.append(c.val)

            current = c.right
        }

        return result
    }
}

// MARK: - Tests

/*:
 ![Testcase](94_testcase.png)
 */

func testSolution(_ solution: Solution) {
    var root = TreeNode(1)
    root.left = TreeNode(2)
    root.left?.left = TreeNode(4)
    root.left?.right = TreeNode(5)
    root.left?.right?.left = TreeNode(6)
    root.left?.right?.right = TreeNode(7)
    root.right = TreeNode(3)
    root.right?.right = TreeNode(8)
    root.right?.right?.left = TreeNode(9)

    let test1Result = solution.inorderTraversal(root)
    assert(
        test1Result == [4, 2, 6, 5, 7, 1, 3, 9, 8],
        "Incorrectly constructed BST"
    )
    print("Test passed!")
}

testSolution(Solution_Recursive())
testSolution(Solution_Loop())

//: [Previous](@previous) || [Next](@next)
