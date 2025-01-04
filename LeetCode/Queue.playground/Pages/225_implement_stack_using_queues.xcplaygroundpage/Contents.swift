/*:
 [225. Implement stack using queues](https://leetcode.com/problems/implement-stack-using-queues/)
 
 #### Solution

 Use two queues and transfer elements on pop and top to maintain the stack order.
 
 **Time Complexity**:
 - Push: _O(1)_
 - Pop: _O(n)_
 - Top: _O(n)_
 - Empty: _O(1)_
 
 */

import Foundation

class Queue<T> {
    private var elements: [T] = []
    
    func enqueue(_ element: T) {
        elements.append(element)
    }
    
    func dequeue() -> T? {
        elements.removeFirst()
    }
    
    func peek() -> T? {
        elements.first
    }
    
    func isEmpty() -> Bool {
        elements.isEmpty
    }
}

class Stack<T> {

    private var queue1: Queue<T> = Queue()
    private var queue2: Queue<T> = Queue()
    
    func push(_ element: T) {
        if !queue2.isEmpty() {
            queue2.enqueue(element)
        } else {
            queue1.enqueue(element)
        }
    }
    
    func pop() -> T {
        getFrontElement(pop: true)
    }
    
    func top() -> T {
        getFrontElement(pop: false)
    }
    
    func empty() -> Bool {
        queue1.isEmpty() && queue2.isEmpty()
    }
    
    private func getFrontElement(pop: Bool) -> T {
        let value = if !queue1.isEmpty() {
            getFrontElement(primaryQueue: queue1, emptyQueue: queue2, popElement: pop)
        } else {
            getFrontElement(primaryQueue: queue2, emptyQueue: queue1, popElement: pop)
        }
        
        guard let value else {
            fatalError("Pop called on empty stack")
        }
        
        return value
    }
    
    private func getFrontElement(primaryQueue: Queue<T>, emptyQueue secondaryQueue: Queue<T>, popElement: Bool) -> T? {
        while let element = primaryQueue.dequeue() {
            let isLast = primaryQueue.isEmpty()
            
            if !isLast {
                secondaryQueue.enqueue(element)
            } else {
                if !popElement {
                    secondaryQueue.enqueue(element)
                }
                
                return element
            }
        }
        
        return nil
    }
}

final class MyStack: Stack<Int> {}

// MARK: - Tests

func testStackOperations() {
    let stack = MyStack()

    // Test isEmpty() on an empty stack
    assert(stack.empty(), "Test failed: Stack should be empty initially")
    print("isEmpty test passed for an empty stack")

    stack.push(10)
    stack.push(20)
    
    // Test top
    assert(stack.top() == 20, "Test failed: Top of stack should be 20")
    print("Push and Top test passed with two elements")

    // Test pop()
    assert(stack.pop() == 20, "Test failed: Pop should return 20")
    print("Pop test passed for first element")

    assert(stack.pop() == 10, "Test failed: Pop should return 10")
    print("Pop test passed for second element")

    // Test isEmpty() after pops
    assert(stack.empty(), "Test failed: Stack should be empty after all pops")
    print("isEmpty test passed after all elements are popped")
}

testStackOperations()

//: [Previous](@previous) || [Next](@next)
