/*:
 [5. Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/description/)
 
 #### Solution
 
 For each index of the array's element, loop towards the array's edges and check if the longest palindrome is met
 
 - **Time Complexity**: _O(n ^ n)_, where n is the length of a and m is the length of m
 - **Space Complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func longestPalindrome(_ s: String) -> String {
        var result = ""
        var maxLength = 0
        var arr = Array(s)

        for i in 0 ..< arr.count {
            var j = i
            var k = i

            while j >= 0 && k < arr.count && arr[j] == arr[k] {
                if k - j + 1 > maxLength {
                    if j == k {
                        result = String(arr[j])
                    } else {
                        result = String(arr[j ... k])
                    }
                    maxLength = k - j + 1
                }
                j -= 1
                k += 1
            }

            j = i
            k = i + 1
            while j >= 0 && k < arr.count && arr[j] == arr[k] {
                if k - j + 1 > maxLength {
                    if j == k {
                        result = String(arr[j])
                    } else {
                        result = String(arr[j ... k])
                    }
                    maxLength = k - j + 1
                }
                j -= 1
                k += 1
            }
        }

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.longestPalindrome("babad") == "bab", "Test failed: longestPalindrome(\"babad\") == \"bab\"")
    print("Test passed: longestPalindrome(\"babad\") == \"bab\"")
    
    assert(solution.longestPalindrome("cbbd") == "bb", "Test failed: longestPalindrome(\"cbbd\") == \"bb\"")
    print("Test passed: longestPalindrome(\"cbbd\") == \"bb\"")
    
    assert(solution.longestPalindrome("a") == "a", "Test failed: longestPalindrome(\"a\") == \"a\"")
    print("Test passed: longestPalindrome(\"a\") == \"a\"")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
