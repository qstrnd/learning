/*:
 [73. Set Matrix Zeroes](https://leetcode.com/problems/set-matrix-zeroes/)
 
 #### Solution
 
 Use the first row and the first column to track if we need to zero them out.
 
 - **Time Complexity**: _O(n * m)_, where n x m is the size of the matrix
 - **Space Complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func setZeroes(_ matrix: inout [[Int]]) {
        let rows = matrix.count
        let cols = matrix[0].count
        
        let isFirstRowZero = matrix[0].contains(0)
        var isFirstColZero = false
        for r in stride(from: 0, to: rows, by: 1) {
            if matrix[r][0] == 0 {
                isFirstColZero = true
                break
            }
        }

        for r in stride(from: 1, to: rows, by: 1) {
            for c in stride(from: 1, to: cols, by: 1) {
                if matrix[r][c] == 0 {
                    matrix[0][c] = 0
                    matrix[r][0] = 0
                }
            }
        }

        for r in stride(from: 1, to: rows, by: 1) {
            for c in stride(from: 1, to: cols, by: 1) {
                if matrix[0][c] == 0 || matrix[r][0] == 0 {
                    matrix[r][c] = 0
                }
            }
        }

        if isFirstRowZero {
            for c in stride(from: 0, to: cols, by: 1) {
                matrix[0][c] = 0
            }
        }

        if isFirstColZero {
            for r in stride(from: 0, to: rows, by: 1) {
                matrix[r][0] = 0
            }
        }

    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    var arr = [[1,1,1],[1,0,1],[1,1,1]]
    solution.setZeroes(&arr)
    assert(arr == [[1,0,1],[0,0,0],[1,0,1]], "Test 1 failed")
    print("Test 1 passed")
    
    arr = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
    solution.setZeroes(&arr)
    assert(arr == [[0,0,0,0],[0,4,5,0],[0,3,1,0]], "Test 2 failed")
    print("Test 2 passed")
    
    arr = [[1,0]]
    solution.setZeroes(&arr)
    assert(arr == [[0,0]], "Test 3 failed")
    print("Test 3 passed")

}

testSolution()

//: [Previous](@previous) || [Next](@next)
