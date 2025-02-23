/*:
 [49. Group Anagrams](https://leetcode.com/problems/group-anagrams/)
 
 #### Solution Slower
 
 Use the sorted string as a key for grouping
 
 - **Time Complexity**: _O(n * m * log(m))_, where n is the number of elements and m is the average length
 - **Space Complexity**: _O(nm)_
 
 #### Solution
 
 To avoid sorting and making performance better, it's possible to build a footprint for each word where characters are counted
 (use array of 26 elements, where index 0 corresponds to a and index 25 to z).
 
 - **Time Complexity**: _O(n * m)_, where n is the number of elements and m is the average length
 - **Space Complexity**: _O(nm)_

 */

import Foundation

final class Solution_Slower {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var groups: [String: [String]] = [:]

        for s in strs {
            let k = String(s.sorted())
            var g = groups[k, default: []]
            g.append(s)
            groups[k] = g
        }

        return Array(groups.values)
    }
}

final class Solution {
    private struct Key: Hashable {
        let counter: [Int]
    }
    
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var groups: [Key: [String]] = [:]

        let a = Character("a").asciiValue!
        for s in strs {
            var k = Array(repeating: 0, count: 26)
            
            for c in s {
                let i = Int(c.asciiValue! - a)
                k[i] += 1
            }
            let key = Key(counter: k)
            
            var g = groups[key, default: []]
            g.append(s)
            groups[key] = g
        }

        return Array(groups.values)
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    var res = solution.groupAnagrams(["eat","tea","tan","ate","nat","bat"])
    assert(isValidAnswer(res, [["eat","tea","ate"],["bat"],["tan","nat"]]), "Test failed: groupAnagrams([\"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\"]) == [[\"eat\",\"tea\",\"ate\"],[\"bat\"],[\"tan\",\"nat\"]]")
    print("Test passed: groupAnagrams([\"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\"]) == [[\"eat\",\"tea\",\"ate\"],[\"bat\"],[\"tan\",\"nat\"]]")
    
    res = solution.groupAnagrams([""])
    assert(isValidAnswer(res, [[""]]), "Test failed: groupAnagrams([\"\"]) == [[\"\"]]")
    print("Test passed: groupAnagrams([\"\"]) == [[\"\"]]")
}

func isValidAnswer(_ res: [[String]], _ expected: [[String]]) -> Bool {
    guard res.count == expected.count else { return false }
    
    struct HashableArray: Hashable {
        let elms: [String]
    }
    
    var resSet: Set<HashableArray> = []
    var expSet: Set<HashableArray> = []
    
    res.forEach { resSet.insert(HashableArray(elms: $0)) }
    expected.forEach { expSet.insert(HashableArray(elms: $0)) }

    return resSet == expSet
}

testSolution()

//: [Previous](@previous) || [Next](@next)
