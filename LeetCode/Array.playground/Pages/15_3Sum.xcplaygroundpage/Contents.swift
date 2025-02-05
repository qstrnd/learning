// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let target = 0
        var nums = nums.sorted()
        var result: [[Int]] = []

        for c in 0 ..< nums.count {
            if c > 0, nums[c] == nums[c - 1] {
                continue
            }

            var i = c + 1
            var j = nums.count - 1

            while i < j {
                let sum = nums[c] + nums[i] + nums[j]
                if sum == target {
                    result.append([nums[c], nums[i], nums[j]])
                    repeat {
                        i += 1
                    } while nums[i] == nums[i - 1] && i < j
                } else if sum > target {
                    repeat {
                        j -= 1
                    } while nums[j] == nums[j + 1] && j > i
                } else {
                    repeat {
                        i += 1
                    } while nums[i] == nums[i - 1] && i < j
                }
            }
        }

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.threeSum([-1, 0, 1, 2, -1, -4]) == [[-1, -1, 2], [-1, 0, 1]], "Test failed: threeSum([-1,0,1,2,-1,-4]) == [[-1,-1,2],[-1,0,1]]")
    print("Test passed: threeSum([-1,0,1,2,-1,-4]) == [[-1,-1,2],[-1,0,1]]")

    assert(solution.threeSum([0, 1, 1]) == [], "Test failed: threeSum([0,1,1]) == [])")
    print("Test passed: threeSum([0,1,1]) == [])")

    assert(solution.threeSum([0, 0, 0]) == [[0, 0, 0]], "Test failed: threeSum([0,0,0]) == [0, 0, 0])")
    print("Test passed: threeSum([0,0,0]) == [0, 0, 0])")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
