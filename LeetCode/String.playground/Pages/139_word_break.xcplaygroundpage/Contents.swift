/*:
 [1512. Number of good pairs](https://leetcode.com/problems/number-of-good-pairs/description/)
 
 #### Solution
 
 1. First thing that may come to mind is just to compair each pair. It would work but it would be almost _O(n^2)_ in complexity,
 because each element would be compaired with all elements that follow it.
 
 2. A more optimal solution is to calculate how many equal numbers are present in the array. We can do this with a hash table,
 since we have the constraint that `1 <= nums[i] <= 100`, we don't have to utilize a lot of memory.
 
 After we got the number of pairs, the combination formula can be applied and the number of pairs needs to be summed.
 
 ![Example GIF](1512_combination_formula.png)
 
 3. There's also a [solution](https://leetcode.com/problems/number-of-good-pairs/solutions/1154018/swift-number-of-good-pairs) where the number of pair is calculated on the go, eliminating the need for a second cycle. Both solutions 2 and 3 have the same O(n) time complexity and O(1) space complexity.
 
 - **Time Complexity**: _O(n)_, where n is the length of the input string s
 - **Space Complexity**: _O(1)_

 */

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
    
    assert(solution.wordBreak("abcd", ["a","abc","b","cd"]) == true, "Test failed: wordBreak(\"abcd\", [\"a\",\"abc\",\"b\",\"cd\"]) == true")
    print("Test passed: wordBreak(\"abcd\", [\"a\",\"abc\",\"b\",\"cd\"]) == true")
    
    assert(solution.wordBreak("applepenapple", ["apple","pen"]) == true, "Test failed: wordBreak(\"applepenapple\", [\"apple\",\"pen\"]) == true")
    print("Test passed: wordBreak(\"applepenapple\", [\"apple\",\"pen\"]) == true")
    
    assert(solution.wordBreak("catsandog", ["cats","dog","sand","and","cat"]) == false, "Test failed: wordBreak(\"catsandog\", [\"cats\",\"dog\",\"sand\",\"and\",\"cat\"]) == false")
    print("Test passed: wordBreak(\"catsandog\", [\"cats\",\"dog\",\"sand\",\"and\",\"cat\"]) == false")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
