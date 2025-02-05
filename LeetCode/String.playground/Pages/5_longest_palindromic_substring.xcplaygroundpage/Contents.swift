// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func longestPalindrome(_ s: String) -> String {
        var result = ""
        var maxLength = 0
        var arr = Array(s)

        for i in 0 ..< arr.count {
            var j = i
            var k = i

            while j >= 0, k < arr.count, arr[j] == arr[k] {
                if k - j + 1 > maxLength {
                    if j == k {
                        result = String(arr[j])
                    } else {
                        result = String(arr[j ... k])
                    }
                    maxLength = k - j + 1
                }
                j -= 1
                k += 1
            }

            j = i
            k = i + 1
            while j >= 0, k < arr.count, arr[j] == arr[k] {
                if k - j + 1 > maxLength {
                    if j == k {
                        result = String(arr[j])
                    } else {
                        result = String(arr[j ... k])
                    }
                    maxLength = k - j + 1
                }
                j -= 1
                k += 1
            }
        }

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.longestPalindrome("babad") == "bab", "Test failed: longestPalindrome(\"babad\") == \"bab\"")
    print("Test passed: longestPalindrome(\"babad\") == \"bab\"")

    assert(solution.longestPalindrome("cbbd") == "bb", "Test failed: longestPalindrome(\"cbbd\") == \"bb\"")
    print("Test passed: longestPalindrome(\"cbbd\") == \"bb\"")

    assert(solution.longestPalindrome("a") == "a", "Test failed: longestPalindrome(\"a\") == \"a\"")
    print("Test passed: longestPalindrome(\"a\") == \"a\"")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
