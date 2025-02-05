// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

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

    assert(solution.missingNumber([3, 0, 1]) == 2, "Test failed: twoSum([3,0,1]) == 2")
    print("Test passed: twoSum([3,0,1]) == 2")

    assert(solution.missingNumber([0, 1]) == 2, "Test failed: twoSum([0,1]) == 2")
    print("Test passed: twoSum([0,1]) == 2")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
