/*:
 [33. Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array/description/)
 
 #### Solution
 
 Narrow down the problem to the binary search: use left, right and middle index.
 If the condition nums[left] <= nums[mid] is true, it means the left part of the array is sorted, or vice versa.
 If the target is in the sorted part, move the index to continue search in this part. Or update the indices to point to
 surround the other part otherwise.
 
 **Time complexity**: _O(log n)_
 **Space complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var l = 0
        var r = nums.count - 1

        while l <= r {
            let m = l + (r - l) / 2

            if nums[m] == target {
                return m
            } else if nums[l] <= nums[m] {
                if target >= nums[l] && target < nums[m] {
                    r = m - 1
                } else {
                    l = m + 1
                }
            } else {
                if target > nums[m] && target <= nums[r] {
                    l = m + 1
                } else {
                    r = m - 1
                }
            }
        }

        return -1
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.search([4,5,6,7,0,1,2], 0) == 4, "Test failed: search([4,5,6,7,0,1,2], 0) == 4")
    print("Test passed: search([4,5,6,7,0,1,2], 0) == 4")
    
    assert(solution.search([4,5,6,7,0,1,2], 3) == -1, "Test failed: search([4,5,6,7,0,1,2], 3) == -1")
    print("Test passed: search([4,5,6,7,0,1,2], 3) == -1")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
