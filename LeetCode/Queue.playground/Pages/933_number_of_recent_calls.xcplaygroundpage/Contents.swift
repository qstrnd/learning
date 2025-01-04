//: [Previous](@previous)

/*:
 [LeetCode Problem](https://leetcode.com/problems/number-of-recent-calls/description/)
 
 #### Solution
 
 Use a queue to track ping time in sequential order and store the count of queued elements. When ping happens, go through the queue, dequeueing the elements until the first encounter of the element that meets the condition [t - 3000, t].
 
 **Time Complexity**: O(1) amortized per ping call.
 **Space Complexity**: O(1) (bounded by 3000 elements) in a queue.
 
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

/*:
 My initial version that is too slow because of being to much straightforward. I reiterated over this version to come up with the final solution (see below)
*/

final class RecentCounter_SlowVersion {
    
    private static let msPeriod: Int = 3000
    
    private var recentTime = 0
    private var queue = Queue<Int>()

    init() {}
    
    func ping(_ time: Int) -> Int {
        precondition(time > recentTime, "Contract is violated: time must be greater than recentTime")
        recentTime = time
        
        var updatedQueue = Queue<Int>()
        let minimalTimeInPeriod = time - Self.msPeriod
        var pingsInPeriod = 1
        while let pingTime = queue.dequeue() {
            if pingTime >= minimalTimeInPeriod {
                pingsInPeriod += 1
                updatedQueue.enqueue(pingTime)
            }
        }
        
        updatedQueue.enqueue(time)
        queue = updatedQueue
        
        return pingsInPeriod
    }
}

final class RecentCounter {
    
    private static let msPeriod: Int = 3000
    
    private var recentTime = 0
    private var queuedPingsCount = 0
    private var queue = Queue<Int>()

    init() {}
    
    func ping(_ time: Int) -> Int {
        precondition(time > recentTime, "Contract is violated: time must be greater than recentTime")
        recentTime = time
        
        queue.enqueue(time)
        queuedPingsCount += 1
        
        let minimalTimeInPeriod = time - Self.msPeriod
        while let pingTime = queue.peek() {
            if pingTime >= minimalTimeInPeriod {
                break
            }
            
            _ = queue.dequeue()
            queuedPingsCount -= 1
        }
        
        return queuedPingsCount
    }
}

func testSolution() {
    let sut = RecentCounter()
    
    assert(sut.ping(1) == 1, "Didn't pass for '1' value")
    print("Passed for '1' value")
    
    assert(sut.ping(100) == 2, "Didn't pass for '100' value")
    print("Passed for '100' value")
    
    assert(sut.ping(3001) == 3, "Didn't pass for '3001' value")
    print("Passed for '3001' value")
    
    assert(sut.ping(3002) == 3, "Didn't pass for '3002' value")
    print("Passed for '3002' value")
}

testSolution()

//: [Next](@next)
