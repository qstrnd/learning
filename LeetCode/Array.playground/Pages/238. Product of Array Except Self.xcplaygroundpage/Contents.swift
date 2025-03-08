/*:
 [238. Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/description/)
 
 #### Solution
 
 If the devision cannot be used, then the product must be calculated by multiplying the product of elements to left and right of the current element.
 
 To do this, run two iteration over the array: first to calculate the prefix products for each element and second reverse iteration to multiply this product by the product of the elements to the right.
  
 **Time complexity**: _O(n)_, where n is the length of the array
 **Space complexity**: _O(1)_, if the output array doesn't count as extra memory
 
 */

import Foundation

class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var output = Array(repeating: 1, count: nums.count)
        
        var prod = nums[0]
        for i in stride(from: 1, to: nums.count, by: 1) {
            output[i] = prod
            prod *= nums[i]
        }

        prod = 1
        for i in stride(from: nums.count - 1, through: 0, by: -1) {
            output[i] *= prod
            prod *= nums[i]
        }

        return output
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.productExceptSelf([1,2,3,4]) == [24,12,8,6], "Test failed: productExceptSelf([1,2,3,4]) == [24,12,8,6]")
    print("Test passed: productExceptSelf([1,2,3,4]) == [24,12,8,6]")
    
    assert(solution.productExceptSelf([-1,1,0,-3,3]) == [0,0,9,0,0], "Test failed: productExceptSelf([-1,1,0,-3,3]) == [0,0,9,0,0]")
    print("Test passed: productExceptSelf([-1,1,0,-3,3]) == [0,0,9,0,0]")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
