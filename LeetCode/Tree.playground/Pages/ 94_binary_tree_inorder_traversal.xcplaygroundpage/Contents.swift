/*:
 [
 94. Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal/)
 
 #### Solution
 
 Simply put, check recursively the left node, the parent, and the right node. [More on Geeks for Geeks](https://www.geeksforgeeks.org/tree-traversals-inorder-preorder-and-postorder/?ref=gcse_outind#inorder-traversal)
  
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
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result: [Int] = []
        traverse(root, result: &result)
        return result
    }

    private func traverse(_ node: TreeNode?, result: inout [Int]) {
        guard let node = node else { return }
        traverse(node.left, result: &result)
        result.append(node.val)
        traverse(node.right, result: &result)
    }
}

// MARK: - Tests

/*:
 ![Testcase](94_testcase.png)
*/

func testSolution() {
    let solution = Solution()
    
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
        test1Result == [4,2,6,5,7,1,3,9,8],
        "Incorrectly constructed BST"
    )
    print("Test passed!")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
