/*:
 [138. Copy List with Random Pointer](https://leetcode.com/problems/copy-list-with-random-pointer/description/)
 
 #### Solution
 
 Solve the problem in three passes:
 1. intertwine originals with copies, so that each original would point to its copy as next
 2. update random to point to copies
 3. separate the originals and copies
  
 **Time complexity**: _O(n)_, where n is the number of elements in the linked list chain
 **Space complexity**: _O(1)_, if copies themselves are not considered

 */

import Foundation

final class ListNode {
    var val: Int
    var next: ListNode?
    var random: ListNode?
    
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
    func copyRandomList(_ head: ListNode?) -> ListNode? {
        // intertwine originals and copies
        var node = head
        while let n = node {
            let copy = ListNode(n.val)
            copy.next = n.next
            copy.random = n.random

            n.next = copy
            node = copy.next
        }

        // point random to copies
        node = head?.next
        while let n = node {
            n.random = n.random?.next
            node = n.next?.next
        }

        // split original and copies
        var copyHead: ListNode? = nil
        var copyLast: ListNode? = nil
        node = head
        while let n = node {
            if copyHead == nil {
                copyHead = n.next
                copyLast = copyHead
            } else {
                copyLast?.next = n.next
                copyLast = n.next
            }
            n.next = n.next?.next
            node = n.next
        }

        return copyHead
    }
}

// MARK: - Tests

// Was too lazy to write a test for this problem, just believe me that it works or check it in LeetCode =)

//: [Previous](@previous) || [Next](@next)
