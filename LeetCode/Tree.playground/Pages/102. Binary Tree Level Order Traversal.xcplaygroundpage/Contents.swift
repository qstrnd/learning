/*:
 [102. Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/description/)
 
 #### Solution
 
 Use dfs search, keeping track of how many elements are left at the current level and how many are added to the next
 
 **Time complexity**: _O(n)_, where n is the number of nodes in the tree
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
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        
        var q: [TreeNode] = [root]
        var res: [[Int]] = []
        var cur: [Int] = []
        var curLvl = 1
        var nextLvl = 0
        
        while !q.isEmpty {
            let n = q.removeFirst()
            
            if let l = n.left {
                q.append(l)
                nextLvl += 1
            }
            if let r = n.right {
                q.append(r)
                nextLvl += 1
            }
            
            cur.append(n.val)
            curLvl -= 1
            if curLvl == 0 {
                res.append(cur)
                cur = []
                curLvl = nextLvl
                nextLvl = 0
            }
        }
        
        return res
    }
}


// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    var root = TreeNode(3)
    root.left = TreeNode(9)
    root.right = TreeNode(20)
    root.right?.left = TreeNode(15)
    root.right?.right = TreeNode(7)
    
    let test1Result = solution.levelOrder(root)
    assert(
        test1Result == [[3],[9,20],[15,7]],
        "Test 1 failed"
    )
    print("Test passed!")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
