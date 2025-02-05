// Copyright © 2025 Andrei (Andy) Iakovlev. See LICENSE file for details.

import Foundation

final class Queue<T> {
    private var elements: [T]

    init(_ elements: [T] = []) {
        self.elements = elements
    }

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

final class Stack<T> {
    private var elements: [T]

    init(_ elements: [T] = []) {
        self.elements = elements
    }

    func push(_ element: T) {
        elements.append(element)
    }

    func pop() -> T? {
        if elements.isEmpty { return nil }

        return elements.removeLast()
    }

    func peek() -> T? {
        elements.last
    }

    func isEmpty() -> Bool {
        elements.isEmpty
    }
}

// MARK: - Simulation

final class Solution_Simulation {
    private var studentsQueue = Queue<Int>()
    private var sandwichesStack = Stack<Int>()

    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        studentsQueue = Queue(students.reversed())
        sandwichesStack = Stack(sandwiches.reversed())

        var studentsLeftCount = students.count
        var skipCycleCount = 0

        while !sandwichesStack.isEmpty() {
            let topSandwich = sandwichesStack.peek()
            guard let firstStudent = studentsQueue.dequeue() else {
                return 0
            }

            if topSandwich == firstStudent {
                skipCycleCount = 0
                studentsLeftCount -= 1
                sandwichesStack.pop()
            } else {
                studentsQueue.enqueue(firstStudent)
                skipCycleCount += 1
                if skipCycleCount == studentsLeftCount {
                    return studentsLeftCount
                }
            }
        }

        return 0
    }
}

// MARK: - Calculation

final class Solution {
    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        var preferCircularCount = 0
        var preferSquareCount = 0

        for preference in students {
            if preference == 0 {
                preferCircularCount += 1
            } else {
                preferSquareCount += 1
            }
        }

        for sandwich in sandwiches {
            if sandwich == 0, preferCircularCount > 0 {
                preferCircularCount -= 1
            } else if sandwich == 1, preferSquareCount > 0 {
                preferSquareCount -= 1
            } else {
                return preferSquareCount + preferCircularCount
            }
        }

        return 0
    }
}

// MARK: - Tests

func testSolution() {
    let sut = Solution()

    assert(sut.countStudents([1, 1, 0, 0], [0, 1, 0, 1]) == 0, "Didn't pass for 'test1'")
    print("Did pass test1")

    assert(sut.countStudents([1, 1, 1, 0, 0, 1], [1, 0, 0, 0, 1, 1]) == 3, "Didn't pass for 'test2'")
    print("Did pass test2")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
