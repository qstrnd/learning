/*:
 [56. Merge Intervals](https://leetcode.com/problems/merge-intervals/description/)
 
 MEDIUM
 
 #### Solution
 
 1. Sort the input array by the start points
 2. Go through the array checking the previous interval for each next one. If overlap is determined, update the last interval instead of appending a new one
 
 - **Time Complexity**: _O(n * log(n))_, where n is the length of the array
 - **Space Complexity**: _O(n)_

 */

import Foundation

final class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        var sortedIntervals = intervals.sorted(by: { $0[0] < $1[0] })
        var result: [[Int]] = []

        for interval in sortedIntervals {
            if let lastInterval = result.last {
                if interval[0] <= lastInterval[1] {
                    _ = result.removeLast()
                    let mergedInterval = [lastInterval[0], max(interval[1], lastInterval[1])]
                    result.append(mergedInterval)
                    continue
                }
            }

            result.append(interval)
        }

        return result
    }
}


// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.merge([[1,3],[2,6],[8,10],[15,18]]) == [[1,6],[8,10],[15,18]], "Test failed: merge([[1,3],[2,6],[8,10],[15,18]]) == [[1,6],[8,10],[15,18]]")
    print("Test passed: merge([[1,3],[2,6],[8,10],[15,18]]) == [[1,6],[8,10],[15,18]]")
    
    
    assert(solution.merge([[1,4],[4,5]]) == [[1,5]], "Test failed: merge([[1,4],[4,5]]) == [[1,5]]")
    print("Test passed: merge([[1,4],[4,5]]) == [[1,5]]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
