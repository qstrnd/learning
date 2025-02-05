// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var numsSet: Set<Int> = []

        for n in nums {
            if numsSet.contains(n) {
                return true
            }
            numsSet.insert(n)
        }

        return false
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.containsDuplicate([1, 2, 3, 1]) == true, "Test failed: containsDuplicate([1,2,3,1]) == true")
    print("Test passed: containsDuplicate([1,2,3,1]) == true")

    assert(solution.containsDuplicate([1, 2, 3, 4]) == false, "Test failed: containsDuplicate([1,2,3,4]) == false")
    print("Test passed: containsDuplicate([1,2,3,4]) == false")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
