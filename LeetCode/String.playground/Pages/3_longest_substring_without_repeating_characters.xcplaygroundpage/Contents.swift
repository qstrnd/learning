// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let s = Array(s)
        var set: Set<Character> = []
        var l = 0
        var res = 0

        for r in 0 ..< s.count {
            while set.contains(s[r]) {
                set.remove(s[l])
                l += 1
            }
            set.insert(s[r])
            res = max(res, r - l + 1)
        }

        return res
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.lengthOfLongestSubstring("abcabcbb") == 3, "Test failed: lengthOfLongestSubstring(\"abcabcbb\") == 3")
    print("Test passed: lengthOfLongestSubstring(\"abcabcbb\") == 3")

    assert(solution.lengthOfLongestSubstring("bbbbb") == 1, "Test failed: lengthOfLongestSubstring(\"bbbbb\") == 1")
    print("Test passed: lengthOfLongestSubstring(\"bbbbb\") == 1")

    assert(solution.lengthOfLongestSubstring("pwwkew") == 3, "Test failed: lengthOfLongestSubstring(\"pwwkew\") == 3")
    print("Test passed: lengthOfLongestSubstring(\"pwwkew\") == 3")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
