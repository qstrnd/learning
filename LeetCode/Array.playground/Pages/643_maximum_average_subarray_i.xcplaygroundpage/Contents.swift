/*:
 [643. Maximum Average Subarray I](https://leetcode.com/problems/maximum-average-subarray-i/description/)
 
 #### Solution
 
 Just use two pointers with fixed destination between one another. Track max average.
 
 - **Time Complexity**: _O(n)_, where n is the length of the array
 - **Space Complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        var i = 0
        var j = k - 1
        var maxAvrg: Double = -10000

        while j < nums.count {
            maxAvrg = max(maxAvrg, Double(nums[i ... j].reduce(0, +)) / Double(k))
            i += 1
            j += 1
        }

        return maxAvrg
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.findMaxAverage([1,12,-5,-6,50,3], 4) == 12.75, "Test failed: findMaxAverage([1,12,-5,-6,50,3], 4) == 12.75")
    print("Test passed: findMaxAverage([1,12,-5,-6,50,3], 4) == 12.75")
    
    assert(solution.findMaxAverage([5], 1) == 5, "Test failed: findMaxAverage([5], 1) == 5")
    print("Test passed: findMaxAverage([5], 1) == 5")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
