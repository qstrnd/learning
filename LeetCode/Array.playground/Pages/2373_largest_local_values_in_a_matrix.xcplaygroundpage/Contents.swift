/*:
 [2373. Largest Local Values in a Matrix](https://leetcode.com/problems/largest-local-values-in-a-matrix/description/)
 
 #### Solution 1
 
 Go through each “center element” of a submatrix where the local maximum is to be located and perform the comparison.
  
 **Time complexity**: _O(n^2)_, where n is the size of the grid
 **Space complexity**: _O(n^2)_, where n is the size of the grid
 
 */

import Foundation

final class Solution {
    func largestLocal(_ grid: [[Int]]) -> [[Int]] {
        var i = 1
        var n = grid.count
        var res: [[Int]] = []
        while (i + 1 < n) {
            var lineRes: [Int] = []
            var j = 1
            while (j + 1 < n) {
                let maxLocal = [
                    grid[i - 1][j - 1], grid[i - 1][j], grid[i - 1][j + 1],
                    grid[i][j - 1], grid[i][j], grid[i][j + 1],
                    grid[i + 1][j - 1], grid[i + 1][j], grid[i + 1][j + 1]
                ].max()!
                lineRes.append(maxLocal)
                j += 1
            }
            res.append(lineRes)
            i += 1
        }
        return res
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.largestLocal([[9,9,8,1],[5,6,2,6],[8,2,6,4],[6,2,2,2]]) == [[9,9],[8,6]], "Test failed: largestLocal([[9,9,8,1],[5,6,2,6],[8,2,6,4],[6,2,2,2]]) == [[9,9],[8,6]]")
    print("Test passed: largestLocal([[9,9,8,1],[5,6,2,6],[8,2,6,4],[6,2,2,2]]) == [[9,9],[8,6]]")
    
    assert(solution.largestLocal([[1,1,1,1,1],[1,1,1,1,1],[1,1,2,1,1],[1,1,1,1,1],[1,1,1,1,1]]) == [[2,2,2],[2,2,2],[2,2,2]], "Test failed: largestLocal([[1,1,1,1,1],[1,1,1,1,1],[1,1,2,1,1],[1,1,1,1,1],[1,1,1,1,1]]) == [[2,2,2],[2,2,2],[2,2,2]]")
    print("Test passed: largestLocal([[1,1,1,1,1],[1,1,1,1,1],[1,1,2,1,1],[1,1,1,1,1],[1,1,1,1,1]]) == [[2,2,2],[2,2,2],[2,2,2]]")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
