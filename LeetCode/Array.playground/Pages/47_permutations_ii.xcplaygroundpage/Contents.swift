/*:
 [47. Permutations II](https://leetcode.com/problems/permutations-ii/description/)
 
 #### Solution
 
 Use a dictionary that stored numbers and their counters to backtrack the solution. Proceed recursively until all the counters are zeroed out.
 
 **Time complexity**: _O(n!)_
 **Space complexity**: _O(n!)_

 */

import Foundation

final class Solution {
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var res: [[Int]] = []
        var perm: [Int] = []
        var count: [Int: Int] = [:]
        for n in nums {
            var c = count[n, default: 0]
            count[n] = c + 1
        }

        func dfs() {
            if perm.count == nums.count {
                res.append(perm)
                return
            }

            for (n, c) in count {
                if c > 0 {
                    perm.append(n)
                    count[n] = c - 1
                    dfs()
                    perm.removeLast()
                    count[n] = c
                }
            }
        }

        dfs()

        return res
    }
}

// MARK: - Tests

struct Triplet: Hashable {
    let a: Int
    let b: Int
    let c: Int
    
    init(_ a: Int, _ b: Int, _ c: Int) {
        self.a = a
        self.b = b
        self.c = c
    }
}

func testSolution() {
    let solution = Solution()
    
    var resultStandard: Set<Triplet> = Set([[2,1,1],[1,2,1],[1,1,2]].map {
        Triplet($0[0], $0[1], $0[2])
    })
    
    var result: Set<Triplet> = Set(solution.permuteUnique([1,1,2]).map {
        Triplet($0[0], $0[1], $0[2])
    })
    
    assert(resultStandard == result, "Test failed: permuteUnique([1,1,2]) == [[2,1,1],[1,2,1],[1,1,2]]")
    print("Test passed: permuteUnique([1,1,2]) == [[2,1,1],[1,2,1],[1,1,2]]")
    
    resultStandard = Set([[3,1,2],[3,2,1],[1,3,2],[1,2,3],[2,3,1],[2,1,3]].map {
        Triplet($0[0], $0[1], $0[2])
    })
    
    result  = Set(solution.permuteUnique([1,2,3]).map {
        Triplet($0[0], $0[1], $0[2])
    })
    
    assert(resultStandard == result, "Test failed: permuteUnique([1,2,3]) == [[3,1,2],[3,2,1],[1,3,2],[1,2,3],[2,3,1],[2,1,3]]")
    print("Test passed: permuteUnique([1,2,3]) == [[3,1,2],[3,2,1],[1,3,2],[1,2,3],[2,3,1],[2,1,3]]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
