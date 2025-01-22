/*:
 [206. Reverse Linked List](https://leetcode.com/problems/reverse-linked-list/)
 
 #### Solution
 
 Add the nodes of the linked list to a stack, mark the new head and pop the elements from the stack. Break the reference to the next node from the new last element.
  
 **Time complexity**: _O(n)_, where n is the number of elements in the linked list chain
 **Space complexity**: _O(1)_, because the linked list nodes will be reused

 */

import Foundation

final class ListNode {
    var val: Int
    var next: ListNode?
    
    init(
        _ val: Int = 0,
        _ next: ListNode? = nil
    ) {
        self.val = val; self.next = next;
    }
    
    func asArray() -> [Int] {
        var result: [Int] = []
        
        var node: ListNode? = self
        while node != nil {
            guard let value = node?.val else { continue }
            result.append(value)
            node = node?.next
        }
        
        return result
    }
}

final class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var stack: [ListNode] = []
        var current = head
        while let c = current, let next = c.next {
            stack.append(c)
            current = next
        }
        let newHead = current
        while !stack.isEmpty {
            let node = stack.removeLast()
            current?.next = node
            current = node
        }
        current?.next = nil
        
        return newHead
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    let head = ListNode(
        1, ListNode(
            2, ListNode(
                3, ListNode(
                    4, ListNode(
                        5, nil
                    )
                )
            )
        )
    )
    
    let test1Result = solution.reverseList(head)?.asArray()
    assert(
        test1Result == [5,4,3,2,1],
        "Test failed: reverseList([1,2,3,4,5]) == [5,4,3,2,1]"
    )
    print("Test passed: reverseList([1,2,3,4,5]) == [5,4,3,2,1]")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
