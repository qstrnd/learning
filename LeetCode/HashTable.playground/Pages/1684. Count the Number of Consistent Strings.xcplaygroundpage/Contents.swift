/*:
 [1684. Count the Number of Consistent Strings](https://leetcode.com/problems/count-the-number-of-consistent-strings/description/)
 
 EASY
 
 #### Solution
 
 Make a set of all characters in `allowed`
 
 - **Time Complexity**: _O(n * m)_, where n is the number of words and m is the average length of the word
 - **Space Complexity**: _O(1)_ (the number of allowed characters is <= 26)

 */

import Foundation

final class Solution {
    func countConsistentStrings(_ allowed: String, _ words: [String]) -> Int {
        var allowed = Set(allowed)
        
        return words.reduce(0) { sum, word in
            for c in word {
                if !allowed.contains(c) {
                    return sum
                }
            }
            return sum + 1
        }
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.countConsistentStrings("ab", ["ad","bd","aaab","baa","badab"]) == 2, "Test failed: countConsistentStrings(\"ab\", [\"ad\",\"bd\",\"aaab\",\"baa\",\"badab\"]) == 2")
    print("Test passed: countConsistentStrings(\"ab\", [\"ad\",\"bd\",\"aaab\",\"baa\",\"badab\"]) == 2")
    
    assert(solution.countConsistentStrings("abc", ["a","b","c","ab","ac","bc","abc"]) == 7, "Test failed: countConsistentStrings(\"abc\", [\"a\",\"b\",\"c\",\"ab\",\"ac\",\"bc\",\"abc\"]) == 7")
    print("Test passed: countConsistentStrings(\"abc\", [\"a\",\"b\",\"c\",\"ab\",\"ac\",\"bc\",\"abc\"]) == 7")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
