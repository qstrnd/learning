/*:
 [322. Coin Change](https://leetcode.com/problems/coin-change/description/)
 
 #### Solution
 
 Use a dynamic programming approach. Solve the problem for all numbers from 0 to n, reusing the solutions for numbers that repeat after subtracting a coin from the current amount.
 
 **Time complexity**: _O(n)_, where n is the amount
 **Space complexity**: _O(n)_

 */

import Foundation

final class Solution {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        var dp = Array(repeating: amount + 1, count: amount + 1)
        dp[0] = 0

        for a in 1 ..< amount + 1 {
            for c in coins {
                if a - c >= 0 {
                    dp[a] = min(dp[a], 1 + dp[a - c])
                }
            }
        }

        if dp[amount] != amount + 1 {
            return dp[amount]
        } else {
            return -1
        }
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.coinChange([1,2,5], 11) == 3, "Test failed: coinChange([1,2,5], 11) == 3")
    print("Test passed: coinChange([1,2,5], 11) == 3")
    
    assert(solution.coinChange([2], 3) == -1, "Test failed: coinChange([2], 3) == -1")
    print("Test passed: coinChange([2], 3) == -1")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
