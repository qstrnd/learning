/*:
 [152. Maximum Product Subarray](https://leetcode.com/problems/maximum-product-subarray/description/)
 
 #### Solution
 
 The key idea is to keep track of both the maximum and minimum product ending at the current index because a negative number can turn a small minimum product into a large maximum product
 
 **Time complexity**: _O(n)_
 **Space complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        var res = nums.max()!
        var curMin = 1
        var curMax = 1

        for n in nums {
            let prevCurMax = curMax
            curMax = [n * curMax, n * curMin, n].max()!
            curMin = [n * prevCurMax, n * curMin, n].min()!
            res = max(res, curMax)
        }

        return res
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.maxProduct([2,3,-2,4]) == 6, "Test failed: maxProduct([2,3,-2,4]) == 6")
    print("Test passed: maxProduct([2,3,-2,4]) == 6")
    
    assert(solution.maxProduct([-2,0,-1]) == 0, "Test failed: maxProduct([-2,0,-1]) == 0")
    print("Test passed: maxProduct([-2,0,-1]) == 0")
    
    assert(solution.maxProduct([5,4,0,4,2]) == 20, "Test failed: maxProduct([5,4,0,4,2]) == 20")
    print("Test passed: maxProduct([5,4,0,4,2]) == 20")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
