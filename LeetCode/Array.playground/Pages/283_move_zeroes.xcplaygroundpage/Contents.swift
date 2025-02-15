/*:
 [283. Move Zeroes](https://leetcode.com/problems/move-zeroes/description)
 
 #### Solution
 
 Use two pointers. Swap numbers when the left pointer is pointing to zero, while the right to a non-zero number.
 
 **Time complexity**: _O(n)_, where n is the length of the array
 **Space complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        var l = 0
        var r = 0
        while r < nums.count {
            if nums[l] == 0 && nums[r] != 0 {
                nums[l] = nums[r]
                nums[r] = 0
                l += 1
                r += 1
            } else if nums[l] == 0 && nums[r] == 0 {
                r += 1
            } else {
                l += 1
                r += 1
            }
        }
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    var array = [0,1,0,3,12]
    solution.moveZeroes(&array)
    assert(array == [1,3,12,0,0], "Test failed: moveZeroes([0,1,0,3,12]) == [1,3,12,0,0]")
    print("Test passed: moveZeroes([0,1,0,3,12]) == [1,3,12,0,0]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
