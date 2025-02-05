// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func findIntersectionValues(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var nums1Elms = Set(nums1)
        var nums2Elms = Set(nums2)
        var a1 = 0
        var a2 = 0

        for n in nums1 {
            a1 += nums2Elms.contains(n) ? 1 : 0
        }

        for n in nums2 {
            a2 += nums1Elms.contains(n) ? 1 : 0
        }

        return [a1, a2]
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.findIntersectionValues([2, 3, 2], [1, 2]) == [2, 1], "Test failed: findIntersectionValues([2,3,2], [1,2]) == [2, 1]")
    print("Test passed: findIntersectionValues([2,3,2], [1,2]) == [2, 1]")

    assert(solution.findIntersectionValues([4, 3, 2, 3, 1], [2, 2, 5, 2, 3, 6]) == [3, 4], "Test failed: findIntersectionValues([4,3,2,3,1], [2,2,5,2,3,6]) == [3,4]")
    print("Test passed: findIntersectionValues([4,3,2,3,1], [2,2,5,2,3,6]) == [3,4]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
