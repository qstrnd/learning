/*:
 [54. Spiral Matrix](https://leetcode.com/problems/spiral-matrix/description/)
 
 #### Solution
 
 Go through the matrix keeping track of the corner borders.
 
 - **Time Complexity**: _O(n * m)_
 - **Space Complexity**: _O(1)_
 
 */

class Solution {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var result: [Int] = []

        var l = 0
        var r = matrix.first?.count ?? 0
        var t = 0
        var b = matrix.count

        while l < r && t < b {
            for i in stride(from: l, to: r, by: 1) {
                result.append(matrix[l][i])
            }
            t += 1
            
            for i in stride(from: l + 1, to: b, by: 1) {
                result.append(matrix[i][r - 1])
            }
            r -= 1

            if l >= r || t >= b { break }

            for i in stride(from: r - 1, through: l, by: -1) {
                result.append(matrix[b - 1][i])
            }
            b -= 1

            for i in stride(from: b - 1, through: t, by: -1) {
                result.append(matrix[i][l])
            }
            l += 1
        }

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.spiralOrder([[1,2,3],[4,5,6],[7,8,9]]) == [1,2,3,6,9,8,7,4,5], "Test failed: spiralOrder([[1,2,3],[4,5,6],[7,8,9]]) == [1,2,3,6,9,8,7,4,5]")
    print("Test passed: spiralOrder([[1,2,3],[4,5,6],[7,8,9]]) == [1,2,3,6,9,8,7,4,5]")
    
    assert(solution.spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]]) == [1,2,3,4,8,12,11,10,9,5,6,7], "Test failed: spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]]) == [1,2,3,4,8,12,11,10,9,5,6,7]")
    print("Test passed: spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]]) == [1,2,3,4,8,12,11,10,9,5,6,7]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
