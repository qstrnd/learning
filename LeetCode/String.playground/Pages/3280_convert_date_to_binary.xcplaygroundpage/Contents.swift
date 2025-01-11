/*:
 [3280. Convert Date to Binary](https://leetcode.com/problems/convert-date-to-binary/description/)
 
 #### Solution

 1. Extract the numbers.
 2. Convert each number to its binary representation. In the decimal system, numbers are represented as decimal fractions, while in the binary system, they are represented as fractions in base 2.
 3. Combine the results into the required form.
 
 Time complexity is an amortized constant due to fixed input size:
 
 - **Time Complexity**: _O(1)_
 - **Space Complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func convertDateToBinary(_ date: String) -> String {
        let components = date.split(separator: "-").map { Int($0)! }

        return [
            buildBinary(from: components[0]),
            "-",
            buildBinary(from: components[1]),
            "-",
            buildBinary(from: components[2])
        ].reduce("", +)
    }

    private func buildBinary(from intValue: Int) -> String {
        var reversedBinary = ""
        var val = intValue
        var carry = 0
        var i = 1
        
        while val > 0 {
            let digit = String(val % 2)
            reversedBinary.append(digit)
            val /= 2
        }
        
        return String(reversedBinary.reversed())
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(Solution().convertDateToBinary("2080-02-29") == "100000100000-10-11101", "Test failed: convertDateToBinary(\"2080-02-29\") == \"100000100000-10-11101\"")
    print("Test passed: convertDateToBinary(\"2080-02-29\") == \"100000100000-10-11101\"")
    
    assert(solution.convertDateToBinary("1900-01-01") == "11101101100-1-1", "Test failed: convertDateToBinary(\"1900-01-01\") == \"11101101100-1-1\"")
    print("Test passed: convertDateToBinary(\"1900-01-01\") == \"11101101100-1-1\"")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
