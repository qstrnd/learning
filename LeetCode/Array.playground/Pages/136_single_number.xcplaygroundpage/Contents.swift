// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

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

    assert(solution.singleNumber([2, 2, 1]) == 1, "Test failed: singleNumber([2,2,1]) == 1")
    print("Test passed: singleNumber([2,2,1]) == 1")

    assert(solution.singleNumber([4, 1, 2, 1, 2]) == 4, "Test failed: singleNumber([4,1,2,1,2]) == 4")
    print("Test passed: singleNumber([4,1,2,1,2]) == 4")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
