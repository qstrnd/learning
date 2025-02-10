/*:
 [22. Generate Parentheses](https://leetcode.com/problems/generate-parentheses/description/)
 
 #### Solution
 
 Use recursive backtrack. Add opening paranthesis until n is reached, and closing only if closeN < openN.
 
 - **Time Complexity**: _O(2 ^ n)_
 - **Space Complexity**: _O(n)_

 */

import Foundation

final class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        var stack: [String] = []
        var result: [String] = []
        
        func backtrack(open: Int, closed: Int) {
            if open == closed && closed == n {
                result.append(stack.joined())
                return
            }

            if open < n {
                stack.append("(")
                backtrack(open: open + 1, closed: closed)
                stack.removeLast()
            }

            if closed < open {
                stack.append(")")
                backtrack(open: open, closed: closed + 1)
                stack.removeLast()
            }
        }

        backtrack(open: 0, closed: 0)

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.generateParenthesis(3) == ["((()))","(()())","(())()","()(())","()()()"], "Test failed: generateParenthesis(3) == [\"((())) \", \"(()()) \", \"(())() \", \"()(())\", \"()()()\"]")
    print("Test passed: generateParenthesis(3) == [\"((())) \", \"(()()) \", \"(())() \", \"()(())\", \"()()()\"]")
    
    assert(solution.generateParenthesis(1) == ["()"], "Test failed: generateParenthesis(1) == [\"()\"]")
    print("Test passed: generateParenthesis(1) == [\"()\"]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
