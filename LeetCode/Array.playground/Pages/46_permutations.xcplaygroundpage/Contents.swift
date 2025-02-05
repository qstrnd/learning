// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []

        if nums.count == 1 {
            return [nums]
        }

        var nums = nums
        for i in 0 ..< nums.count {
            var n = nums.removeFirst()
            var perms = permute(nums)

            for i in 0 ..< perms.count {
                var perm = perms[i]
                perm.append(n)
                perms[i] = perm
            }
            result.append(contentsOf: perms)
            nums.append(n)
        }

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.permute([1, 2, 3]) == [[3, 2, 1], [2, 3, 1], [1, 3, 2], [3, 1, 2], [2, 1, 3], [1, 2, 3]],
           "Test failed: permute([1, 2, 3]) == [[3,2,1],[2,3,1],[1,3,2],[3,1,2],[2,1,3],[1,2,3]]")
    print("Test passed: permute([1, 2, 3]) == [[3,2,1],[2,3,1],[1,3,2],[3,1,2],[2,1,3],[1,2,3]]")

    assert(solution.permute([0, 1]) == [[1, 0], [0, 1]], "Test failed: permute([0,1]) == [[1,0],[0,1]]")
    print("Test passed: permute([0,1]) == [[1,0],[0,1]]")

    assert(solution.permute([1]) == [[1]], "Test failed: permute([1]) == [[1]]")
    print("Test passed: permute([1]) == [[1]]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
