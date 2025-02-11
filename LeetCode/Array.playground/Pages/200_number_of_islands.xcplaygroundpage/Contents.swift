/*:
 [200. Number of Islands](https://leetcode.com/problems/number-of-islands/description/)
 
 #### Solution
 
 Taken from https://leetcode.com/problems/number-of-islands/solutions/3564423/number-of-islands/
 
 Iterate through every point. When on an island point, use breadth first search to traverse all the points that belong to the
 island and nullify them. Count the number of islands.
 
 **Time complexity**: _O(m * n)_, where m is the number of rows in the grid and n is the number of columns. In the worst case, we iterate through each cell in the grid once.
 **Space complexity**: _O(m * n)_ as well. This is because additional memory is used for the recursive calls of the DFS function and for storing the grid with islands.

 */

import Foundation

final class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        var grid = grid
        var numberOfIslands = 0
        
        for row in 0..<grid.count {
            for col in 0..<grid[0].count {
                if grid[row][col] == "1" {
                    dfs(&grid, row, col)
                    numberOfIslands += 1
                }
            }
        }
        return numberOfIslands
    }
    
    private func dfs(_ grid: inout [[Character]], _ row: Int, _ col: Int) {
        if row < 0 || row >= grid.count || col < 0 || col >= grid[0].count { return }
        if grid[row][col] != "1" { return }
        grid[row][col] = "0"

        dfs(&grid, row - 1, col)
        dfs(&grid, row + 1, col)
        dfs(&grid, row, col - 1)
        dfs(&grid, row, col + 1)
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    var grid: [[Character]] = [
        ["1","1","1","1","0"],
        ["1","1","0","1","0"],
        ["1","1","0","0","0"],
        ["0","0","0","0","0"]
    ]
    assert(solution.numIslands(grid) == 1, "Test 1 for numIslands failed")
    print("Test 1 for numIslands passed")
    
    grid = [
        ["1","1","0","0","0"],
        ["1","1","0","0","0"],
        ["0","0","1","0","0"],
        ["0","0","0","1","1"]
    ]
    assert(solution.numIslands(grid) == 3, "Test 2 for numIslands failed")
    print("Test 2 for numIslands passed")
    
}

testSolution()

//: [Previous](@previous) || [Next](@next)
