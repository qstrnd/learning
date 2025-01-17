/*:
 [1038. Binary Search Tree to Greater Sum Tree](https://leetcode.com/problems/binary-search-tree-to-greater-sum-tree/description/)
 
 #### Solution
 
 Use reverse in-order traversal. First find the larget element (it's the rightmost value),
 then keep track of the sum and update the rest of the elements
  
 **Time complexity**: _O(n)_, where n is the number of elements in the tree
 **Space complexity**: _O(n)_, where n is the number of elements in the tree

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

    func bstToGst(_ root: TreeNode?) -> TreeNode? {
        var sum = 0
        var stack: [TreeNode] = []
        var node = root

        while !stack.isEmpty || node != nil {
            while let n = node {
                stack.append(n)
                node = n.right
            }

            node = stack.isEmpty ? nil : stack.removeLast()

            sum += node?.val ?? 0
            node?.val = sum

            node = node?.left
        }

        return root
    }
}

// MARK: - Tests

/*:
 ![Testcase](1038_testcase.png)
*/

func testSolution() {
    let solution = Solution()
    
    var root = TreeNode(4)
    root.left = TreeNode(1)
    root.left?.left = TreeNode(0)
    root.left?.right = TreeNode(2)
    root.left?.right?.right = TreeNode(3)
    root.right = TreeNode(6)
    root.right?.left = TreeNode(5)
    root.right?.right = TreeNode(7)
    root.right?.right?.right = TreeNode(8)
    
    let test1Result = solution.bstToGst(root)?.asArray()
    assert(
        test1Result == [Optional(30),Optional(36),Optional(21),Optional(36),Optional(35),Optional(26),Optional(15),nil,nil,nil,Optional(33),nil,nil,nil,Optional(8)],
        "Incorrectly constructed BST"
    )
    print("Test passed!")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
