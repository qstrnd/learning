// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

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

//: [Previous](@previous) || [Next](@next)
