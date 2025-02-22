/*:
 [210. Course Schedule II](https://leetcode.com/problems/course-schedule-ii/description/)

 */

import Foundation

/*:
 
 1. Build a map to hold all prerequisites for each course for faster access
 2. Use dfs to perform a topological search in the graph of dependencies. Track visited nodes to progress in result. Track visiting nodes to detect a cycle
 
 - **Time Complexity**: _O(n + p)_, where n is the number of courses and p is the number of prerequisites
  - **Space Complexity**: _O(n)_
 
 */

final class Solution {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var map: [Int: Set<Int>] = [:]

        for c in stride(from: 0, to: numCourses, by: 1) {
            map[c] = Set()
        }

        for elm in prerequisites {
            let c = elm[0]
            let p = elm[1]

            var s = map[c]
            s!.insert(p)
            map[c] = s
        }

        var res: [Int] = []
        var visited: Set<Int> = []
        var visiting: Set<Int> = [] // to track cycles

        func dfs(_ c: Int) -> Bool {
            if visited.contains(c) {
                return true
            } else if visiting.contains(c) {
                return false
            }
            visiting.insert(c)
            
            for pr in map[c, default: Set()] {
                if dfs(pr) == false {
                    return false
                }
            }
            res.append(c)
            visited.insert(c)
            visiting.remove(c)

            return true
        }

        for (c, _) in map {
            if dfs(c) == false {
                return []
            }
        }

        return res
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.findOrder(2, [[1,0]]) == [0,1], "Test failed: findOrder(2, [[1,0]]) == [0, 1]")
    print("Test passed: findOrder(2, [[1,0]]) == [0, 1]")
    
    assert(solution.findOrder(4, [[1,0],[2,0],[3,1],[3,2]]) == [0,2,1,3], "Test failed: findOrder(4, [[1,0],[2,0],[3,1],[3,2]]) == [0, 2, 1, 3]")
    print("Test passed: findOrder(4, [[1,0],[2,0],[3,1],[3,2]]) == [0, 2, 1, 3]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
