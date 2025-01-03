/*:
 [LeetCode Problem](https://leetcode.com/problems/implement-stack-using-queues/)
 
 #### Solution

 Use a queue to track elements in order of their appearance
 and a hash map (character -> int) to store indices of their first occurrence.

 The **time complexity** is _O(n)_: the algorithm needs to go through each character in the input string.
 The second loop that goes through the queue doesn't have much significance, as it cannot exceed the number of lowercase characters
 (i.e., <= 26), which results in _O(1)_ time complexity.

 The **memory complexity** is _O(1)_ because neither `orderedUniqueCharacters` nor `firstIndices` will ever store more than 26 elements.
 
 */

import Foundation

class Queue<T> {
    private var elements: [T] = []
    
    func enqueue(_ element: T) {
        elements.append(element)
    }
    
    func dequeue() -> T? {
        if elements.isEmpty { return nil }
        
        return elements.removeFirst()
    }
    
    func peek() -> T? {
        elements.first
    }
    
    func isEmpty() -> Bool {
        elements.isEmpty
    }
}

class Solution {
    var orderedUniqueCharacters = Queue<Character>()
    var firstIndices: [Character: Int] = [:]
    
    func firstUniqChar(_ s: String) -> Int {
        orderedUniqueCharacters = Queue()
        firstIndices = [:]
        
        var index = 0
        for char in s {
            if firstIndices[char] == nil {
                firstIndices[char] = index
                orderedUniqueCharacters.enqueue(char)
            } else {
                firstIndices[char] = -1 // mark that the char is not unique
            }
            
            index += 1
        }
        
        while let char = orderedUniqueCharacters.dequeue() {
            if let index = firstIndices[char], index != -1 {
                return index
            }
        }
        
        return -1
    }
}

func testSolution() {
    let sut = Solution()
    
    assert(sut.firstUniqChar("loveleetcode") == 2, "Didn't pass for 'loveleetcode' value")
    print("Passed for 'loveleetcode' value")
    
    assert(sut.firstUniqChar("aabb") == -1, "Didn't pass for 'aabb' value")
    print("Passed for 'aabb' value")
}

testSolution()
