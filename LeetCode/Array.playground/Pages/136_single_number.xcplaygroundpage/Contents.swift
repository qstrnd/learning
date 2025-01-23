/*:
 [136. Single Number](https://leetcode.com/problems/single-number/description/)
 
 #### Solution
 
 XOR all the elements. The elements in pair will nihilate each other, while the one that is the
 unique element will be the result
 
 **Time complexity**: _O(n)_
 **Space complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var result = 0

        for n in nums {
            result ^= n
        }

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.singleNumber([2,2,1]) == 1, "Test failed: singleNumber([2,2,1]) == 1")
    print("Test passed: singleNumber([2,2,1]) == 1")
    
    assert(solution.singleNumber([4,1,2,1,2]) == 4, "Test failed: singleNumber([4,1,2,1,2]) == 4")
    print("Test passed: singleNumber([4,1,2,1,2]) == 4")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
