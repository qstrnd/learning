// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func generate(_ numRows: Int) -> [[Int]] {
        var result: [[Int]] = []

        for i in 1 ... numRows {
            result.append(
                makeNext(basedOn: result.last ?? [])
            )
        }

        return result
    }

    private func makeNext(basedOn prev: [Int]) -> [Int] {
        guard !prev.isEmpty else {
            return [1]
        }

        var line: [Int] = []
        var k = 0
        for i in 0 ..< prev.count + 1 {
            if i == 0 || i == prev.count {
                line.append(1)
            } else {
                line.append(prev[k] + prev[k + 1])
                k += 1
            }
        }

        return line
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.generate(5) == [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]], "Test failed: generate(5)")
    print("Test passed: generate(5)")

    assert(solution.generate(1) == [[1]], "Test failed: generate(1)")
    print("Test passed: generate(1)")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
