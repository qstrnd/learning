/*:
 [1143. Longest Common Subsequence](https://leetcode.com/problems/longest-common-subsequence/description/)
 
 #### Solution
 
 Use a grid n x m to represent a dynamic programming solution search, where n is the length of text1 and m is the length is text2.
 Beginning from the bottom right corner of the table, for each grid[i][j] the are two cases how to find the max common string:
 1. if text1[i] == text2[j], then lcs[i][j] = 1 + lcs(text1[i + 1 ...], text[j + 1 ...])
 2. if text1[j] != text2[j], then compare the max between lcs(text1[i...], text[j + 1]) and lcs(text1[i + 1...], text[j...]), which corresponds to checking the orthogonal values closer to the bottom right edge.
 
 A detailed explanation at NeetCode: https://www.youtube.com/watch?v=Ua0GhsJSlWM&list=PLot-Xpze53lfOdF3KwpMSFEyfE77zIwiP&index=21
 
  
 **Time complexity**: _O(n * m)_, where n is the length of text1 and m is the length is text2
 **Space complexity**: _O((n + 1) * (m + 1))_, because the linked list nodes will be reused

 */

import Foundation

final class Solution {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        var dp = Array(
            repeating: Array(repeating: 0, count: text2.count + 1),
            count: text1.count + 1
        )
        let text1 = Array(text1)
        let text2 = Array(text2)

        for i in stride(from: text1.count - 1, through: 0, by: -1) {
            for j in stride(from: text2.count - 1, through: 0, by: -1) {
                if text1[i] == text2[j] {
                    dp[i][j] = 1 + dp[i + 1][j + 1]
                } else {
                    dp[i][j] = max(dp[i + 1][j], dp[i][j + 1])
                }
            }
        }

        return dp[0][0]
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.longestCommonSubsequence("abcde", "ace") == 3, "Test failed longestCommonSubsequence(\"abcde\", \"ace\") == 3")
    print("Test passed longesCommonSubsequence(\"abcde\", \"ace\") == 3")
    
    assert(solution.longestCommonSubsequence("abc", "abc") == 3, "Test failed longestCommonSubsequence(\"abc\", \"abc\") == 3")
    print("Test passed longesCommonSubsequence(\"abc\", \"abc\") == 3")
    
    assert(solution.longestCommonSubsequence("abc", "def") == 0, "Test failed longestCommonSubsequence(\"abc\", \"def\") == 0")
    print("Test passed longesCommonSubsequence(\"abc\", \"def\") == 0")
    
}

testSolution()

//: [Previous](@previous) || [Next](@next)
