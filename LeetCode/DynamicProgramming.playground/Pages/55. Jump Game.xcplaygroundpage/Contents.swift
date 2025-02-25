/*:
 [55. Jump Game](https://leetcode.com/problems/jump-game/description/)
 
 #### Solution: Dynamic Programming
 
 My first iteration: use a dp to track if a given point can lead to the goal.
  
 **Time complexity**: _O(n)_, where n is the length of the array
 **Space complexity**: _O(n)_
 
 #### Solution: Greedy
 
 Use a goal starting from the last element and updating it dynamically to the element from which the end point can be achieved.
  
 **Time complexity**: _O(n)_, where n is the length of the array
 **Space complexity**: _O(1)_

 */

import Foundation

final class Solution_dp {
    func canJump(_ nums: [Int]) -> Bool {
        var dp = Array(repeating: true, count: nums.count)

        outer: for i in stride(from: nums.count - 2, through: 0, by: -1) {
            for j in stride(from: i + 1, through: min(i + nums[i], nums.count - 1), by: 1) {
                if dp[j] == true {
                    continue outer
                }
            }
            dp[i] = false
        }

        return dp[0]
    }
}

final class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        var goal = nums.count - 1

        for i in stride(from: nums.count - 2, through: 0, by: -1) {
            if i + nums[i] >= goal {
                goal = i
            }
        }

        return goal == 0
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.canJump([2,3,1,1,4]) == true, "Test failed canJump([2,3,1,1,4]) == true")
    print("Test passed canJump([2,3,1,1,4]) == true")
    
    assert(solution.canJump([3,2,1,0,4]) == false, "Test failed canJump([3,2,1,0,4]) == false")
    print("Test passed canJump([3,2,1,0,4]) == false")
    
}

testSolution()

//: [Previous](@previous) || [Next](@next)
