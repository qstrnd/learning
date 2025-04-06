/*:
 [120. Triangle](https://leetcode.com/problems/triangle/description/)
 
 #### Solution
 
 Start calculating the shortest path from the bottom line of the triangle. To calculate each next line,
 it's only enough to hold in memory the result for the line below it.
 
  
 **Time complexity**: _O(n^2)_
 **Space complexity**: _O(n)_, where n is the length of the last line / the height of the triangle

 */

import Foundation

final class Solution {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let lastLineCount = triangle[triangle.count - 1].count
        var dp: [Int] = Array(repeating: 0, count: lastLineCount + 1)

        for line in stride(from: triangle.count - 1, through: 0, by: -1) {
            for i in stride(from: 0, through: line, by: 1) {
                dp[i] = triangle[line][i] + min(dp[i], dp[i + 1])
            }
        }

        return dp[0]
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]]) == 11, "Test failed minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]]) == 11")
    print("Test passed minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]]) == 11")
    
    assert(solution.minimumTotal([[-10]]) == -10, "Test failed minimumTotal([[-10]]) == -10")
    print("Test passed minimumTotal([[-10]]) == -10")
    
}

testSolution()

//: [Previous](@previous) || [Next](@next)
