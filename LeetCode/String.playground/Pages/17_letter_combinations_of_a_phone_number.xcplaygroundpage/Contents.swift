/*:
 [17. Letter Combinations of a Phone Number](https://leetcode.com/problems/letter-combinations-of-a-phone-number/description/)
 
 #### Solution
 
 Use backtracking to explore all valid combinations.
 
 - **Time Complexity**: _O(k^n)_, where k is the number of letters per digit (up to 4) and n is the number of digits
 - **Space Complexity**: _O(k^n)_

 */

import Foundation

final class Solution {
    func letterCombinations(_ digits: String) -> [String] {
        var stack: [String] = []
        var res: [String] = []

        func backtrack(digitsLeft: String) {
            if digitsLeft.isEmpty {
                if !stack.isEmpty {
                    res.append(stack.joined())
                }
                return
            }

            let digit = String(digitsLeft.prefix(1))
            let letters = map(digit: digit)

            for letter in letters {
                stack.append(letter)
                backtrack(digitsLeft: String(digitsLeft.dropFirst()))
                stack.removeLast()
            }
        }

        backtrack(digitsLeft: digits)

        return res
    }

    private func map(digit: String) -> [String] {
        switch digit {
        case "2":
            return ["a", "b", "c"]
        case "3":
            return ["d", "e", "f"]
        case "4":
            return ["g", "h", "i"]
        case "5":
            return ["j", "k", "l"]
        case "6":
            return ["m", "n", "o"]
        case "7":
            return ["p", "q", "r", "s"]
        case "8":
            return ["t", "u", "v"]
        case "9":
            return ["w", "x", "y", "z"]
        default:
            return []
        }
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.letterCombinations("23") == ["ad","ae","af","bd","be","bf","cd","ce","cf"], "Test failed: letterCombinations(\"23\") == [\"ad\", \"ae\", \"af\", \"bd\", \"be\", \"bf\", \"cd\", \"ce\", \"cf\"]")
    print("Test passed: letterCombinations(\"23\") == [\"ad\", \"ae\", \"af\", \"bd\", \"be\", \"bf\", \"cd\", \"ce\", \"cf\"]")
    
    assert(solution.letterCombinations("") == [], "Test failed: letterCombinations(\"\") == []")
    print("Test passed: letterCombinations(\"\") == []")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
