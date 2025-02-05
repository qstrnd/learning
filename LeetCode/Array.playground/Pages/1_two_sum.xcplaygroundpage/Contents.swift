// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // target = nums[i] + nums[j], i != j
        var pairs: [Int: Int] = [:]

        for i in 0 ..< nums.count {
            let pair = target - nums[i]
            if let j = pairs[pair] {
                return [j, i]
            }
            pairs[nums[i]] = i
        }

        assertionFailure("We're guaranteed to have a solution")
        return []
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.twoSum([2, 7, 11, 15], 9) == [0, 1], "Test failed: twoSum([2,7,11,15], 9) == [0, 1]")
    print("Test passed: twoSum([2,7,11,15], 9) == [0, 1]")

    assert(solution.twoSum([3, 2, 4], 6) == [1, 2], "Test failed: twoSum([3,2,4], 6) == [1, 2]")
    print("Test passed: twoSum([3,2,4], 6) == [1, 2]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
