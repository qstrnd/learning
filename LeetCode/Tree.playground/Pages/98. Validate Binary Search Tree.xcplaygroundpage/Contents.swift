/*:
 [98. Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/description/)
 
 #### Solution
 
 Perform dfs, verifying for each node that it satisfies its min and max constraints.
  
 **Time complexity**: _O(n)_, where n is the number of elements in the tree
 **Space complexity**: _O(1)_

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
    func isValidBST(_ root: TreeNode?) -> Bool {
        func dfs(_ node: TreeNode?, _ min: Int, _ max: Int) -> Bool {
            guard let node = node else {
                return true
            }
            
            guard node.val > min && node.val < max else {
                return false
            }

            return dfs(node.left, min, node.val) && dfs(node.right, node.val, max)
        }

        return dfs(root, Int.min, Int.max)
    }
}

// MARK: - Tests

/*:
 ![Testcase](94_testcase.png)
*/

func testSolution() {
    let solution = Solution()
    
    var root = TreeNode(5)
    root.left = TreeNode(1)
    root.right = TreeNode(7)
    root.right?.left = TreeNode(4)
    root.right?.right = TreeNode(8)
    
    var testResult = solution.isValidBST(root)
    assert(
        testResult == false,
        "Test 1 failed: expected false, got \(testResult) for input: \(root.asArray())"
    )
    print("Test 1 passed: got \(testResult) for input: \(root.asArray())")
    
    root = TreeNode(5)
    root.left = TreeNode(1)
    root.right = TreeNode(7)
    root.right?.left = TreeNode(6)
    root.right?.right = TreeNode(8)
    
    testResult = solution.isValidBST(root)
    assert(
        testResult == true,
        "Test 1 failed: expected true, got \(testResult) for input: \(root.asArray())"
    )
    print("Test 1 passed: got \(testResult) for input: \(root.asArray())")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
