/*:
 [3110. Score of a string](https://leetcode.com/problems/score-of-a-string/description/)
 
 #### Solution
 
 Just go through each character, starting from index 1, and compare it with previous one.
 The hardest part is to remember how to get the ascii value of a character in Swift
 
 - **Time Complexity**: _O(n)_, where n is the length of the input string s
 - **Space Complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func scoreOfString(_ s: String) -> Int {
        let s = Array(s)
        var i = 1
        var sum = 0

        while i < s.count {
            let a = Int(s[i - 1].asciiValue ?? 0)
            let b = Int(s[i].asciiValue ?? 0)
            
            sum += abs(a - b)
            i += 1
        }

        return sum
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.scoreOfString("hello") == 13, "Test failed: scoreOfString(\"hello\") == 13")
    print("Test passed: scoreOfString(\"hello\") == 13")
    
    assert(solution.scoreOfString("zaz") == 50, "Test failed: scoreOfString(\"zaz\") == 50")
    print("Test passed: scoreOfString(\"zaz\") == 50")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
