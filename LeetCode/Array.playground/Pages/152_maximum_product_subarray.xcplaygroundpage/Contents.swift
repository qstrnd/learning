// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

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

    assert(solution.maxProduct([2, 3, -2, 4]) == 6, "Test failed: maxProduct([2,3,-2,4]) == 6")
    print("Test passed: maxProduct([2,3,-2,4]) == 6")

    assert(solution.maxProduct([-2, 0, -1]) == 0, "Test failed: maxProduct([-2,0,-1]) == 0")
    print("Test passed: maxProduct([-2,0,-1]) == 0")

    assert(solution.maxProduct([5, 4, 0, 4, 2]) == 20, "Test failed: maxProduct([5,4,0,4,2]) == 20")
    print("Test passed: maxProduct([5,4,0,4,2]) == 20")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
