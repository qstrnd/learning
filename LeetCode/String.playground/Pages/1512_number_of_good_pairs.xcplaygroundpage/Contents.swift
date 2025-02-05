// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution_2Cycles {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        var vals: [Int: Int] = [:]

        for n in nums {
            let count = vals[n, default: 0]
            vals[n] = count + 1
        }

        var sum = 0
        for (num, count) in vals {
            sum += count * (count - 1) / 2
        }

        return sum
    }
}

final class Solution {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        var res = 0
        var count: [Int: Int] = [:]

        for num in nums {
            res += count[num, default: 0]
            count[num, default: 0] += 1
        }

        return res
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.numIdenticalPairs([1, 2, 3, 1, 1, 3]) == 4, "Test failed: numIdenticalPairs([1,2,3,1,1,3]) == 4")
    print("Test passed: numIdenticalPairs([1,2,3,1,1,3]) == 4")

    assert(solution.numIdenticalPairs([1, 1, 1, 1]) == 6, "Test failed: numIdenticalPairs([1, 1, 1, 1]) == 6")
    print("Test passed: numIdenticalPairs([1, 1, 1, 1]) == 6")

    assert(solution.numIdenticalPairs([1, 2, 3]) == 0, "Test failed: numIdenticalPairs([1, 2, 3]) == 0")
    print("Test passed: numIdenticalPairs([1, 2, 3]) == 0")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
