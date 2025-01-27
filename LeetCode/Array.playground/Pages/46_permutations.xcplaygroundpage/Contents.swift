/*:
 [46. Permutations](https://leetcode.com/problems/permutations/description/)
 
 #### Solution
 
 It's a backtracking type of problem. The solutions may be visially represented as a tree.
 
 ![A tree representing the solution](46_solution_tree.png)
 [Image Source](https://leetcode.com/problems/permutations/solutions/5976304/complex-backtracking-interview-prepare-list-of-common-backtracking-problems-beats-100/)
 
 To implement the solution, one can take the first element and find the permutations for the rest of the elements using a recursion, then move the element to the last position and repeat it for every element.
 
 **Time complexity**: _O(n!)_
 **Space complexity**: _O(n!)_

 */

import Foundation

final class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []

        if nums.count == 1 {
            return [nums]
        }

        var nums = nums
        for i in 0 ..< nums.count {
            var n = nums.removeFirst()
            var perms = permute(nums)

            for i in 0 ..< perms.count {
                var perm = perms[i]
                perm.append(n)
                perms[i] = perm
            }
            result.append(contentsOf: perms)
            nums.append(n)
        }

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.permute([1, 2, 3]) == [[3,2,1],[2,3,1],[1,3,2],[3,1,2],[2,1,3],[1,2,3]]
, "Test failed: permute([1, 2, 3]) == [[3,2,1],[2,3,1],[1,3,2],[3,1,2],[2,1,3],[1,2,3]]")
    print("Test passed: permute([1, 2, 3]) == [[3,2,1],[2,3,1],[1,3,2],[3,1,2],[2,1,3],[1,2,3]]")
    
    assert(solution.permute([0,1]) == [[1,0],[0,1]], "Test failed: permute([0,1]) == [[1,0],[0,1]]")
    print("Test passed: permute([0,1]) == [[1,0],[0,1]]")
    
    assert(solution.permute([1]) == [[1]], "Test failed: permute([1]) == [[1]]")
    print("Test passed: permute([1]) == [[1]]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
