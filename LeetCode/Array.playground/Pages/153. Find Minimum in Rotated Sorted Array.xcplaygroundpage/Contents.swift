/*:
 [153. Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description/)
 
 #### Solution
 
 Use a binary search. At each step, check in what part the minimum value might be.
 
 **Time complexity**: _O(log n)_
 **Space complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func findMin(_ nums: [Int]) -> Int {
        var l = 0
        var r = nums.count - 1

        while l < r {
            let m = l + (r - l) / 2
            if nums[m] > nums[r] {
                l = m + 1
            } else {
                r = m
            }
        }

        return nums[l]
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.findMin([3,4,5,1,2]) == 1, "Test failed: findMin([3,4,5,1,2]) == 1")
    print("Test passed: findMin([3,4,5,1,2]) == 1")
    
    assert(solution.findMin([4,5,6,7,0,1,2]) == 0, "Test failed: findMin([4,5,6,7,0,1,2]) == 0")
    print("Test passed: findMin([4,5,6,7,0,1,2]) == 0")
    
    assert(solution.findMin([11,13,15,17]) == 11, "Test failed: findMin([11,13,15,17]) == 11")
    print("Test passed: findMin([11,13,15,17]) == 11")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
