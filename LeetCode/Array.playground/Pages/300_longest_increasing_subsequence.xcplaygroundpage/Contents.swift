/*:
 [300. Longest Increasing Subsequence](https://leetcode.com/problems/longest-increasing-subsequence/description/)
 
 #### Solution
 
 Solve the problem for each element, starting from the last one. Keep track of the
 
 **Time complexity**: _O(n^2)_, where n is the length of the array
 **Space complexity**: _O(n)_

 */

import Foundation

final class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        var lis = Array(repeating: 0, count: nums.count)
        var res = 0

        var i = nums.count - 1
        while i >= 0 {
            var localLis = 1
            var j = i + 1
            while j < nums.count {
                if nums[j] > nums[i] {
                    localLis = max(localLis, 1 + lis[j])
                }
                j += 1
            }
            lis[i] = localLis
            res = max(res, localLis)
            i -= 1
        }

        return res
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.lengthOfLIS([10,9,2,5,3,7,101,18]) == 4, "Test failed: lengthOfLIS([10,9,2,5,3,7,101,18]) == 4")
    print("Test passed: lengthOfLIS([10,9,2,5,3,7,101,18]) == 4")
    
    assert(solution.lengthOfLIS([0,1,0,3,2,3]) == 4, "Test failed: lengthOfLIS([0,1,0,3,2,3]) == 4")
    print("Test passed: lengthOfLIS([0,1,0,3,2,3]) == 4")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
