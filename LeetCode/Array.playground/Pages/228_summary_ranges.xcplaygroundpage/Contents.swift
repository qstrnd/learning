/*:
 [228. Summary Ranges](https://leetcode.com/problems/summary-ranges/description)
 
 #### Solution
 
 Iterate through elements, keeping track when the new range begins
  
 **Time complexity**: _O(n)_, where n is the length of the array
 **Space complexity**: _O(n)_, where n is the length of the array
 
 */

import Foundation

final class Solution {
    func summaryRanges(_ nums: [Int]) -> [String] {
        guard nums.count > 0 else { return [] }
        var result: [String] = []

        var begin = nums[0]
        for i in 1 ..< nums.count {
            let n = nums[i]
            if nums[i - 1] == n - 1 {
                continue
            } else if nums[i - 1] == begin {
                result.append("\(begin)")
                begin = nums[i]
            } else {
                result.append("\(begin)->\(nums[i - 1])")
                begin = nums[i]
            }
        }

        if begin == nums[nums.count - 1] {
            result.append("\(begin)")
        } else {
            result.append("\(begin)->\(nums[nums.count - 1])")
        }

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.summaryRanges([0,1,2,4,5,7]) == ["0->2","4->5","7"], "Test failed: summaryRanges([0,1,2,4,5,7]) == ['0->2','4->5','7']")
    print("Test passed: summaryRanges([0,1,2,4,5,7]) == ['0->2','4->5','7']")
    
    assert(solution.summaryRanges([0,2,3,4,6,8,9]) == ["0","2->4","6","8->9"], "Test failed: summaryRanges([0,2,3,4,6,8,9]) == ['0','2->4','6','8->9']")
    print("Test passed: summaryRanges([0,2,3,4,6,8,9]) == ['0','2->4','6','8->9']")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
