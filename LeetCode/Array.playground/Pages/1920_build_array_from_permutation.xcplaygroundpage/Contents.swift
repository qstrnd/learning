// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

class Solution_Naive {
    func buildArray(_ nums: [Int]) -> [Int] {
        var i = 0
        var res: [Int] = []
        while i < nums.count {
            res.append(nums[nums[i]])
            i += 1
        }
        return res
    }
}

class Solution {
    func buildArray(_ nums: [Int]) -> [Int] {
        var nums = nums
        let q = nums.count
        for (i, c) in nums.enumerated() {
            nums[i] += q * (nums[c] % q)
        }
        for (i, _) in nums.enumerated() {
            nums[i] = nums[i] / q
        }
        return nums
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.buildArray([0, 2, 1, 5, 3, 4]) == [0, 1, 2, 4, 5, 3], "Test failed: buildArray([0,2,1,5,3,4]) == [0,1,2,4,5,3]")
    print("Test passed: buildArray([0,2,1,5,3,4]) == [0,1,2,4,5,3]")

    assert(solution.buildArray([5, 0, 1, 2, 3, 4]) == [4, 5, 0, 1, 2, 3], "Test failed: buildArray([5,0,1,2,3,4]) == [4,5,0,1,2,3]")
    print("Test passed: buildArray([5,0,1,2,3,4]) == [4,5,0,1,2,3]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
