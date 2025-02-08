/*:
 [70. Climbing Stairs](https://leetcode.com/problems/climbing-stairs/description)
 
 #### Solution 1
 
 Calculate the number of steps for each staircase from the lowest to highest.
 Given that the number of steps can be either 1 or 2,
 it's possible to reuse the calculations for i - 1 and i - 2 staircase when calculating the current level
 
 - **Time Complexity**: _O(n)_
 - **Space Complexity**: _O(n)_
 
 */

final class Solution {
    func climbStairs(_ n: Int) -> Int {
        if n == 1 {
            return 1
        } else if n == 2 {
            return 2
        }

        var dp = Array(repeating: 0, count: n)
        dp[0] = 1
        dp[1] = 2

        for i in 2 ..< n {
            dp[i] = dp[i - 1] + dp[i - 2]
        }

        return dp[n - 1]
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.climbStairs(2) == 2, "Test failed: climbStairs(2) == 2")
    print("Test passed: climbStairs(2) == 2")
    
    assert(solution.climbStairs(3) == 3, "Test failed: climbStairs(3) == 3")
    print("Test passed: climbStairs(3) == 3")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
