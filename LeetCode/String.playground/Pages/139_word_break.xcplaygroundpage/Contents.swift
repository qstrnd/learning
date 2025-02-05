// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        let sCount = s.count
        var dp = Array(repeating: false, count: sCount)
        var wordCountCache: [String: Int] = [:]
        for word in wordDict {
            wordCountCache[word] = word.count
        }

        for i in stride(from: sCount - 1, through: 0, by: -1) {
            for word in wordDict {
                guard !dp[i] else { continue }
                let wordCount = wordCountCache[word]!
                let startIndex = s.index(s.startIndex, offsetBy: i)
                guard i + wordCount <= sCount else { continue }
                let endIndex = s.index(s.startIndex, offsetBy: i + wordCount)
                let substring = String(s[startIndex ..< endIndex])
                guard substring == word else { continue }
                let nextIndex = i + wordCount
                if nextIndex == sCount {
                    dp[i] = true
                } else {
                    dp[i] = dp[i + wordCount]
                }
            }
        }

        return dp[0]
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.wordBreak("abcd", ["a", "abc", "b", "cd"]) == true, "Test failed: wordBreak(\"abcd\", [\"a\",\"abc\",\"b\",\"cd\"]) == true")
    print("Test passed: wordBreak(\"abcd\", [\"a\",\"abc\",\"b\",\"cd\"]) == true")

    assert(solution.wordBreak("applepenapple", ["apple", "pen"]) == true, "Test failed: wordBreak(\"applepenapple\", [\"apple\",\"pen\"]) == true")
    print("Test passed: wordBreak(\"applepenapple\", [\"apple\",\"pen\"]) == true")

    assert(solution.wordBreak("catsandog", ["cats", "dog", "sand", "and", "cat"]) == false, "Test failed: wordBreak(\"catsandog\", [\"cats\",\"dog\",\"sand\",\"and\",\"cat\"]) == false")
    print("Test passed: wordBreak(\"catsandog\", [\"cats\",\"dog\",\"sand\",\"and\",\"cat\"]) == false")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
