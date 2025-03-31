/*:
 [1963. Minimum Number of Swaps to Make the String Balanced](https://leetcode.com/problems/minimum-number-of-swaps-to-make-the-string-balanced/description/)
 
 #### Solution
 
 Go through the string, keeping track of the max of unpaired closed brackets at the moment. Then calcualte the number of swaps using the formula (maxClosed + 1) / 2. The division is required because a swap cancels out another swap, and +1 insures that for odd results the division will be correct.
 
 - **Time Complexity**: _O(n)_, where n is the length of the input string s
 - **Space Complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func minSwaps(_ s: String) -> Int {
        var closed = 0
        var maxClosed = 0

        for c in s {
            if c == "[" {
                closed -= 1
            } else {
                closed += 1
            }
            maxClosed = max(maxClosed, closed)
        }

        return (maxClosed + 1) / 2
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.minSwaps("][][") == 1, "Test failed: minSwaps(\"[][]\") == 1")
    print("Test passed: minSwaps(\"[][]\") == 1")
    
    assert(solution.minSwaps("]]][[[") == 2, "Test failed: minSwaps(\"]]][[[)\") == 2")
    print("Test passed: minSwaps(\"]]][[[)\") == 2")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
