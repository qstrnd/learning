/*:
 [268. Missing Number](https://leetcode.com/problems/missing-number/description/)
 
 #### Solution
 
 Since the condition is very strict and all numbers are unique from 0 to n with only one missing,
 it's enough to calculate the sum of the sequence using the formula `S(n)=n*(n+1)/2` and then
 substract the numbers in the input array. The value that is left is the missing value.
 
 **Time complexity**: _O(n)_, where n is the length of the array
 **Space complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func missingNumber(_ nums: [Int]) -> Int {
        var sum = nums.count * (nums.count + 1) / 2

        for num in nums {
            sum -= num
        }

        return sum
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.missingNumber([3,0,1]) == 2, "Test failed: twoSum([3,0,1]) == 2")
    print("Test passed: twoSum([3,0,1]) == 2")
    
    assert(solution.missingNumber([0,1]) == 2, "Test failed: twoSum([0,1]) == 2")
    print("Test passed: twoSum([0,1]) == 2")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
