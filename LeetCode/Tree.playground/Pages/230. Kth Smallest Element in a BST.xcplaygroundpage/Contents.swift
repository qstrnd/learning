/*:
 [230. Kth Smallest Element in a BST](https://leetcode.com/problems/kth-smallest-element-in-a-bst/description/)

 #### Solution
 
 Use iterative in-order traversal to find the Kth element.

 The worst case:
 
 **Time complexity**: _O(n)_
 **Space complexity**: _O(n)_

 */

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
            if let node = node {
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
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var stack: [TreeNode] = []
        var cur: TreeNode? = root
        var n = 0

        while cur != nil || !stack.isEmpty {
            while let c = cur {
                stack.append(c)
                cur = c.left
            }

            let c = stack.removeLast()
            n += 1
            if n == k {
                return c.val
            }

            cur = c.right
        }

        return -1
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    var root = TreeNode(5)
    root.left = TreeNode(3)
    root.left?.left = TreeNode(2)
    root.left?.left?.left = TreeNode(1)
    root.left?.right = TreeNode(4)
    root.right = TreeNode(6)
    
    assert(solution.kthSmallest(root, 3) == 3, "Test failed: kthSmallest([5,3,2,1,4,6], 3) == 3")
    print("Test passed: kthSmallest([5,3,2,1,4,6], 3) == 3")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
