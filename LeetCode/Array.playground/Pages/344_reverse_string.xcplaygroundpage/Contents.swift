/*:
 [344. Reverse String](https://leetcode.com/problems/reverse-string/)
 
 #### Solution
 
 Use two pointers (indices) and iterate, moving the indices towards the center and swapping the value at each iteration
 
 - **Time Complexity**: _O(n)_, where n is the length of the string
 - **Space Complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func reverseString(_ s: inout [Character]) {
        var i = 0
        var j = s.count - 1

        while i < j {
            s.swapAt(i, j)
            i += 1
            j -= 1
        }
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    var str: [Character] = ["h","e","l","l","o"]
    solution.reverseString(&str)
    assert(str == ["o","l","l","e","h"], "Test failed: reverseString([\"h\",\"e\",\"l\",\"l\",\"o\"]) == [\"o\",\"l\",\"l\",\"e\",\"h\"]")
    print("Test passed: reverseString([\"h\",\"e\",\"l\",\"l\",\"o\"]) == [\"o\",\"l\",\"l\",\"e\",\"h\"]")
    
    str = ["H","a","n","n","a","h"]
    solution.reverseString(&str)
    assert(str == ["h","a","n","n","a","H"], "Test  failed: reverseString([\"H\",\"a\",\"n\",\"n\",\"a\",\"H\"]) == [\"h\",\"a\",\"n\",\"n\",\"a\",\"H\"]")
    print("Test passed: reverseString([\"H\",\"a\",\"n\",\"n\",\"a\",\"H\"]) == [\"h\",\"a\",\"n\",\"n\",\"a\",\"H\"]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
