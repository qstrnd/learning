/*:
 [191. Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits/description/)

 */

import Foundation

protocol Solution {
    func hammingWeight(_ n: Int) -> Int
}

/*:
 
 #### Solution 1
 
 Calculate the Hamming weight using modulo and division
 
 - **Time Complexity**: _O(log n)_, where n is the number of digits in the base-10 representation of the number.
 - **Space Complexity**: _O(1)_
 
 */

final class Solution1: Solution {
    func hammingWeight(_ n: Int) -> Int {
        var n = n
        var c = 0
        while n > 0 {
            c += n % 2
            n /= 2
        }
        return c
    }
}

/*:
 
 #### Solution 2
 
 Calculate the Hamming by clearing the least significant set bit in a loop
 
 - **Time Complexity**: _O(log n)_, where n is the number of digits in the base-10 representation of the number.
 - **Space Complexity**: _O(1)_
 
 */

final class Solution2: Solution {
    func hammingWeight(_ n: Int) -> Int {
        var n = n
        var c = 0
        while n > 0 {
            n = n & (n - 1); // Clear the least significant set bit in n
            c += 1
        }
        return c
    }
}

/*:
 
 #### Solution 3
 
 Precompute results for reusable subranges
 
 - **Time Complexity**: _O(log n)_, where n is the number of digits in the base-10 representation of the number.
 - **Space Complexity**: _O(1)_
 
 */

final class Solution3: Solution {
    let lookupTable: [Int] = {
        var table = [Int](repeating: 0, count: 256)
        for i in 0 ..< 256 {
            table[i] = (i & 1) + table[i >> 1]
        }
        return table
    }()
    
    func hammingWeight(_ n: Int) -> Int {
        var n = n
        var c = 0
        while n != 0 {
            c += lookupTable[n & 0xFF] // Process 8 bits at a time
            n >>= 8
        }
        return c
    }
}

// MARK: - Tests

func testSolution(_ solution: Solution) {
    let solution = Solution1()
    
    assert(solution.hammingWeight(11) == 3, "Test failed: hammingWeight(11) == 3")
    print("Test passed: hammingWeight(11) == 3")
    
    assert(solution.hammingWeight(2147483645) == 30, "Test failed: hammingWeight(2147483645) == 30")
    print("Test passed: hammingWeight(2147483645) == 30")
}

testSolution(Solution1())
testSolution(Solution2())
testSolution(Solution3())

//: [Previous](@previous) || [Next](@next)
