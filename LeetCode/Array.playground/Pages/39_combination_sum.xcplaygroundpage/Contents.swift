    /*:
     [39. Combination Sum](https://leetcode.com/problems/combination-sum/description/)
     
     #### Solution
     
     Use backtracking and dfs search to build a decision tree. On each iteration, either include the current element, or proceed only with the
     next elements from the array
     
     **Time complexity**: _O(2^t)_, where t is the target
     **Space complexity**: _O(t/d)_, where t is the target and d is the smallest candidate, representing the depth of recursion

     */

    import Foundation

    final class Solution {
        func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
            var result: [[Int]] = []
            var cur: [Int] = []

            func dfs(_ i: Int, _ total: Int) {
                if total == target {
                    result.append(cur)
                    return
                } else if i >= candidates.count || total > target {
                    return
                }

                cur.append(candidates[i])
                dfs(i, total + candidates[i])
                cur.removeLast()
                dfs(i + 1, total)
            }

            dfs(0, 0)

            return result
        }
    }

    // MARK: - Tests

    func testSolution() {
        let solution = Solution()
        
        assert(solution.combinationSum([2,3,6,7], 7) == [[2,2,3],[7]], "Test failed: combinationSum(arr: [2,3,6,7], target: 7) == [[2,2,3],[7]]")
        print("Test passed: combinationSum(arr: [2,3,6,7], target: 7) == [[2,2,3],[7]]")
        
        assert(solution.combinationSum([2], 1) == [], "Test failed: combinationSum(arr: [2], target: 1) == [[]]")
        print("Test passed: combinationSum(arr: [2], target: 1) == [[]]")
    }

    testSolution()

    //: [Previous](@previous) || [Next](@next)
