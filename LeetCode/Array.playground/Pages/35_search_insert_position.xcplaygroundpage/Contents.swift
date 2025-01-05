/*:
 [35. Search insert position](https://leetcode.com/problems/search-insert-position/)
 
 #### Solution
 
 Use binary search to locate the index for target element
 
 **Time complexity**: _O(log n)_

 */

import Foundation

final class Solution {
    
    func searchInsert(_ array: [Int], _ target: Int) -> Int {
        var startIndex = 0
        var endIndex = array.count - 1
        
        while startIndex <= endIndex {
            let midIndex = startIndex + (endIndex - startIndex) / 2
            let midElement = array[midIndex]
            
            if target > midElement {
                startIndex = midIndex + 1
            } else if target < midElement {
                endIndex = midIndex - 1
            } else {
                return midIndex
            }
        }
        
        return startIndex
    }
    
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.searchInsert([1,3,5,6], 5) == 2, "Test failed: insertPosition(arr: [1,3,5,6], target: 5) == 2")
    print("Test passed: insertPosition(arr: [1,3,5,6], target: 5) == 2")
    
    assert(solution.searchInsert([1,3,5,6], 2) == 1, "Test failed: insertPosition(arr: [1,3,5,6], target: 2) == 1")
    print("Test passed: insertPosition(arr: [1,3,5,6], target: 2) == 1")

    assert(solution.searchInsert([1,3,5,6], 7) == 4, "Test failed: insertPosition(arr: [1,3,5,6], target: 7) == 4")
    print("Test passed: insertPosition(arr: [1,3,5,6], target: 7) == 4")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
