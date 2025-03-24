/*:
 [62. Unique Paths](https://leetcode.com/problems/unique-paths/description/)
 
 MEDIUM
 
 #### Solution
 
 Use a dynamic programming approach, calculating the paths from the bottom right corner
 
 - **Time Complexity**: _O(n * m)_
 - **Space Complexity**: _O(n * m)_

 */

import Foundation

final class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

        dp[m - 1][n] = 1 // add this so that the right bottom corner has 1 path
        
        for i in stride(from: m - 1, through: 0, by: -1) {
            for j in stride(from: n - 1, through: 0, by: -1) {
                dp[i][j] = dp[i + 1][j] + dp[i][j + 1]
            }
        }

        return dp[0][0]
    }
}


// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.uniquePaths(3, 7) == 28, "Test failed: uniquePaths(3, 7) == 28")
    print("Test passed: uniquePaths(3, 7) == 28")
    
    assert(solution.uniquePaths(3, 2) == 3, "Test failed: uniquePaths(3, 2) == 3")
    print("Test passed: uniquePaths(3, 2) == 3")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
