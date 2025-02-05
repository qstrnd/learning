// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var i = 0
        var j = numbers.count - 1

        while i < j {
            let sum = numbers[i] + numbers[j]
            if sum < target {
                i += 1
            } else if sum > target {
                j -= 1
            } else {
                return [i + 1, j + 1]
            }
        }

        assertionFailure("We're guaranteed to have exactly one solution")
        return []
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.twoSum([2, 7, 11, 15], 9) == [1, 2], "Test failed: twoSumTwo([2,7,11,15], 9) == [1, 2]")
    print("Test passed: twoSumTwo([2,7,11,15], 9) == [1, 2]")

    assert(solution.twoSum([2, 3, 4], 6) == [1, 3], "Test failed: twoSumTwo([2,3,4], 6) == [1,3]")
    print("Test passed: twoSumTwo([2,3,4], 6) == [1,3]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
