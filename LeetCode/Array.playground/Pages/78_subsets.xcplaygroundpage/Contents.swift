/*:
 [78. Subsets](https://leetcode.com/problems/subsets/description/)
 
 #### Solution
 
 Use backtracking to find all possible solutions.
 
 - **Time Complexity**: _O(2^n)_, where n is the length of the array
 - **Space Complexity**: _O(2^n)_

 */

import Foundation

final class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = [[]]
        var curr: [Int] = []

        func backtrack(_ nums: [Int]) {
            for i in 0 ..< nums.count {
                let n = nums[i]
                curr.append(n)
                result.append(curr)
                let j = i + 1
                if j < nums.count - 1 {
                    backtrack(Array(nums[j ... nums.count - 1]))
                } else if j == nums.count - 1 {
                    backtrack([nums[j]])
                }
                curr.removeLast()
            }
        }

        backtrack(nums)

        return result
    }
}


// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.subsets([1,2,3]) == [[],[1],[1,2],[1,2,3],[1,3],[2],[2,3],[3]], "Test failed: subsets([1,2,3]) == [[],[1],[1,2],[1,2,3],[1,3],[2],[2,3],[3]]")
    print("Test passed: subsets([1,2,3]) == [[],[1],[1,2],[1,2,3],[1,3],[2],[2,3],[3]]")
    
    assert(solution.subsets([0]) == [[], [0]], "Test failed: subsets([0]) == [[], [0]]")
    print("Test passed: subsets([0]) == [[], [0]]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
