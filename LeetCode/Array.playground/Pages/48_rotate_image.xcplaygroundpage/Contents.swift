/*:
 [48. Rotate Image](https://leetcode.com/problems/rotate-image/description/)
 
 #### Solution
 
 To rotate a matrix by 90 degrees, transpose it and then flip it vertically.

 Example:
 
 [ 1, 2, 3 ]     [ 1, 4, 7 ]     [ 7, 4, 1 ]
 [ 4, 5, 6 ] --> [ 2, 5, 8 ] --> [ 8, 5, 2 ]
 [ 7, 8, 9 ]     [ 3, 6, 9 ]     [ 9, 6, 3 ]
 
 - **Time Complexity**: _O(n ^ 2)_, where n is the size of the matrix
 - **Space Complexity**: _O(1)_, because no additional space is used

 */

import Foundation

final class Solution {
    func rotate(_ matrix: inout [[Int]]) {
        let n = matrix.count

        var limit = 0
        for y in 0 ..< n {
            var x = 0
            while x < limit {
                let a = matrix[y][x]
                matrix[y][x] = matrix[x][y]
                matrix[x][y] = a
                x += 1
            }
            limit += 1
        }

        limit = n / 2

        for y in 0 ..< n {
            var x = 0
            while x < limit {
                let a = matrix[y][x]
                matrix[y][x] = matrix[y][n - 1 - x]
                matrix[y][n - 1 - x] = a

                x += 1
            }
        }
    }
}


// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    var matrix = [[1,2,3],[4,5,6],[7,8,9]]
    solution.rotate(&matrix)
    assert(matrix == [[7,4,1],[8,5,2],[9,6,3]], "Test failed: rotate([[1,2,3],[4,5,6],[7,8,9]]) == [[7,4,1],[8,5,2],[9,6,3]]")
    print("Test passed: rotate([[1,2,3],[4,5,6],[7,8,9]]) == [[7,4,1],[8,5,2],[9,6,3]]")
    
    matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
    solution.rotate(&matrix)
    assert(matrix == [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]], "Test failed: rotate([[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]]) == [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]")
    print("Test passed: rotate([[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]]) == [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
