// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        if a.isEmpty { return b }
        if b.isEmpty { return a }

        let a = Array(a)
        let b = Array(b)
        var i = a.count - 1
        var j = b.count - 1
        var carry = 0
        var result: [Int] = []

        while i >= 0 || j >= 0 || carry > 0 {
            var sum = carry

            if i >= 0, a[i] == "1" { sum += 1 }
            if j >= 0, b[j] == "1" { sum += 1 }

            carry = sum >= 2 ? 1 : 0
            let digit = sum % 2
            result.append(digit)

            i -= 1
            j -= 1
        }

        return result.reversed().reduce(into: "") { partialResult, val in
            partialResult.append(String(val))
        }
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.addBinary("11", "1") == "100", "Test failed: addBinary(\"11\", \"1\") == \"100\"")
    print("Test passed: addBinary(\"11\", \"1\") == \"100\"")

    assert(solution.addBinary("1010", "") == "1010", "Test failed: addBinary(\"1010\", \"\") == \"1010\"")
    print("Test passed: addBinary(\"1010\", \"\") == \"1010\"")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
