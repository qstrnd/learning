/*:
 [96. Unique Binary Search Trees](https://leetcode.com/problems/unique-binary-search-trees/description/)
 
 MEDIUM
 
 #### Solution
 
 Calculate the number of trees using a dynamic programming approach,
 taking into account that given a number of nodes n there is a fixed number of possible binary trees that can be built
 
 See Catalan number formula https://en.wikipedia.org/wiki/Catalan_number
 
 - **Time Complexity**: _O(n^2)_, where n is the number of tree nodes
 - **Space Complexity**: _O(n)_

 */

import Foundation

class Solution {
    func numTrees(_ n: Int) -> Int {
        var dp = Array(repeating: 1, count: n + 1)

        for i in stride(from: 2, to: n + 1, by: 1) {
            var total = 0

            for j in stride(from: 0, to: i, by: 1) {
                total += (dp[j] * dp[i - j - 1])
            }

            dp[i] = total
        }

        return dp[n]
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.numTrees(3) == 5, "Test failed: numTrees(3) == 5")
    print("Test passed: numTrees(3) == 5")
    
    assert(solution.numTrees(4) == 14, "Test failed: numTrees(4) == 14")
    print("Test passed: numTrees(4) == 14")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
