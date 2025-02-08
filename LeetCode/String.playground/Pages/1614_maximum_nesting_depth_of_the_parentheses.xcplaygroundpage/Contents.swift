/*:
 [1614. Maximum Nesting Depth of the Parentheses](https://leetcode.com/problems/maximum-nesting-depth-of-the-parentheses/description/)
 
 #### Solution
 
 Go through each character, increasing the count of an opening brace is met and decreasing if a closing one is met.
 Keep track of the max.
 
 - **Time Complexity**: _O(n)_, where n is the length of the input string s
 - **Space Complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func maxDepth(_ s: String) -> Int {
        var max = 0
        var cur = 0

        for ch in s {
            switch ch {
                case "(":
                    cur += 1
                case ")":
                    cur -= 1
                default:
                    continue
            }

            max = Swift.max(max, cur)
        }

        return max
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.maxDepth("(1+(2*3)+((8)/4))+1") == 3, "Test failed: maxDepth(\"(1+(2*3)+((8)/4))+1\")) == 3")
    print("Test passed: maxDepth(\"(1+(2*3)+((8)/4))+1\")) == 3")
    
    assert(solution.maxDepth("()(())((()()))") == 3, "Test failed: maxDepth(\"()(())((()())\") == 3")
    print("Test passed: maxDepth(\"()(())((()())\") == 3")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
