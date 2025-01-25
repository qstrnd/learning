/*:
 [217. Contains Duplicate](https://leetcode.com/problems/contains-duplicate/description/)
 
 #### Solution
 
 Go through each “center element” of a submatrix where the local maximum is to be located and perform the comparison.
  
 **Time complexity**: _O(n)_, where n is the length of the array
 **Space complexity**: _O(n)_, where n is the length of the array
 
 */

import Foundation

final class Solution {
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var numsSet: Set<Int> = []

        for n in nums {
            if numsSet.contains(n) {
                return true
            }
            numsSet.insert(n)
        }

        return false
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.containsDuplicate([1,2,3,1]) == true, "Test failed: containsDuplicate([1,2,3,1]) == true")
    print("Test passed: containsDuplicate([1,2,3,1]) == true")
    
    assert(solution.containsDuplicate([1,2,3,4]) == false, "Test failed: containsDuplicate([1,2,3,4]) == false")
    print("Test passed: containsDuplicate([1,2,3,4]) == false")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
