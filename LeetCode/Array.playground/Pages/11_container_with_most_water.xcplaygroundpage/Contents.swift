/*:
 [11. Container With Most Water](https://leetcode.com/problems/container-with-most-water/description/)
 
 #### Solution
 
 Use two pointers and shift the left one to the right if the left bar is less than the right one and vice versa.
 
 **Time complexity**: _O(n)_, where n is the number of elements in the array
 **Space complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var res = 0
        var l = 0
        var r = height.count - 1

        while l < r {
            let cur = min(height[l], height[r]) * (r - l)
            res = max(res, cur)
            
            if height[l] < height[r] {
                l += 1
            } else if height[l] > height[r] {
                r -= 1
            } else {
                if height[l + 1] > height[r - 1] {
                    l += 1
                } else {
                    r -= 1
                }
            }
        }

        return res
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.maxArea([1,8,6,2,5,4,8,3,7]) == 49, "Test failed: maxArea([1,8,6,2,5,4,8,3,7]) == 49")
    print("Test passed: maxArea([1,8,6,2,5,4,8,3,7]) == 49")
    
    assert(solution.maxArea([1,1]) == 1, "Test failed: maxArea([1,1]) == 1")
    print("Test passed: maxArea([1,1]) == 1")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
