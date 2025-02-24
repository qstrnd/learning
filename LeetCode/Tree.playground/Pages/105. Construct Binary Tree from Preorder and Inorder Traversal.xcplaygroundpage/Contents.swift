/*:
 [105. Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/)
 
 #### Solution
 
 Build a tree recursively knowing that the first elements in the preorder array is a root -> allows us to know how many elements in each subtree from the inorder array -> split both arrays to construct left and right subtrees
 
 **Time complexity**: _O(n*log(n))_, where n is the number of nodes in the tree
 **Space complexity**: _O(n^2)_
 
 #### Ideas for optimization
 
 - instead of using `firstIndex(of:)`, prepare a hash map where the elements are mapped to their indices in the inorder array
 - don't copy arrays, but pass indices
 
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
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        guard !preorder.isEmpty && !inorder.isEmpty else {
            return nil
        }

        let root = TreeNode(preorder[0])
        let mid = inorder.firstIndex(of: root.val)!
        root.left = buildTree(
            Array(preorder[1 ..< mid + 1]),
            Array(inorder[0 ..< mid])
        )
        root.right = buildTree(
            Array(preorder[mid + 1 ..< preorder.count]),
            Array(inorder[mid + 1 ..< inorder.count])
        )

        return root
    }
}


// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    var result = TreeNode(3)
    result.left = TreeNode(9)
    result.right = TreeNode(20)
    result.right?.left = TreeNode(15)
    result.right?.right = TreeNode(7)
    
    let testResult = solution.buildTree([3,9,20,15,7], [9,3,15,20,7])
    assert((testResult?.asArray() ?? []) == result.asArray(), "Test failed")
    print("Test passed!")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
