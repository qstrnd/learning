/*:
 [19. Remove Nth Node From End of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/)
 
 #### Solution 1 with hash map
 
 Map index of element to the element itself. Then handle the following situations (R is the position of the element to be removed):
    [R, n, n]
    [R]
    [n, R, n]
    [n, n, R]
 
 **Time complexity**: _O(n)_, where n is the number of elements in the linked list
 **Space complexity**: _O(n)_
 
 #### Solution 2 with two pointers
 
 Use two pointers with the distance of n elements in between.
 To be able to remove the nth element and avoid a special case for head, use a dummy node at the beginning
 
 **Time complexity**: _O(n)_, where n is the number of elements in the linked list
 **Space complexity**: _O(1)_

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

protocol Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode?
}

final class Solution1_HashMap: Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var indexedNodes: [Int: ListNode] = [:]
        var curr = 0
        var node = head
        while node != nil {
            indexedNodes[curr] = node
            node = node?.next
            curr += 1
        }
        var toRemove = curr - n
        if toRemove == 0 {
            if curr == 1 {
                return nil
            } else {
                return head?.next
            }
        } else {
            indexedNodes[toRemove - 1]?.next = indexedNodes[toRemove + 1]
            return head
        }
    }
}

final class Solution2_TwoPointers: Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var dummyNode = ListNode(0, head)
        
        var l: ListNode? = dummyNode
        var r: ListNode? = head
        for _ in 0 ..< n {
            r = r?.next
        }
        
        while r != nil {
            l = l?.next
            r = r?.next
        }
        
        l?.next = l?.next?.next
        
        return dummyNode.next
    }
}

// MARK: - Tests

func testSolution(_ solution: Solution) {
    var list = ListNode(
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
    
    assert(
        solution.removeNthFromEnd(list, 2)?.asArray() == [1,2,3,5], "Test failed: removeNthFromEnd([1,2,3,4,5], 2) != [1,2,3,5]"
    )
    print("Test passed: removeNthFromEnd([1,2,3,4,5], 2) == [1,2,3,5]")
    
    list = ListNode(
        1, nil
    )
    
    assert(
        solution.removeNthFromEnd(list, 1)?.asArray() == nil, "Test failed: removeNthFromEnd([1], 1) != nil"
    )
    print("Test passed: removeNthFromEnd([1], 1) == nil")
    
    list = ListNode(
        1, ListNode(
            2, nil
        )
    )
        
    assert(
        solution.removeNthFromEnd(list, 1)?.asArray() == [1], "Test failed: removeNthFromEnd([1,2], 1) != [1]"
    )
    print("Test passed: removeNthFromEnd([1,2], 1) == [1]")
}

testSolution(Solution1_HashMap())
testSolution(Solution2_TwoPointers())

//: [Previous](@previous) || [Next](@next)
