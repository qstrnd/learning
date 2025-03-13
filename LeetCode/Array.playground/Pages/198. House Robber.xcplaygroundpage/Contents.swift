/*:
 [198. House Robber](https://leetcode.com/problems/house-robber/description/)
 
 #### Solution
 
 Since the array is sorted, use two indices and move them towards the center depending on the difference between the target sum and the current some
 
 **Time complexity**: _O(n)_, where n is the length of the array
 **Space complexity**: _O(n)_

 */

import Foundation

final class Solution {
    func rob(_ nums: [Int]) -> Int {
        var dp: Array<Int?> = Array(repeating: nil, count: nums.count)
        func max(from i: Int) -> Int {
            let res: Int
            if i >= nums.count {
                res = 0
            } else if i == nums.count - 1 {
                res = nums[i]
            } else {
                if let r = dp[i] {
                    res = r
                } else {
                    var a = nums[i] + max(from: i + 2)
                    var b = nums[i + 1] + max(from: i + 3)
                    res = Swift.max(a, b)
                    dp[i] = res
                }
            }

            return res
        }

        return max(from: 0)
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.rob([1,2,3,1]) == 4, "Test failed: rob([1,2,3,1]) == 4")
    print("Test passed: rob([1,2,3,1]) == 4")
    
    assert(solution.rob([2,7,9,3,1]) == 12, "Test failed: rob([2,7,9,3,1]) == 12")
    print("Test passed: rob([2,7,9,3,1]) == 12")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
