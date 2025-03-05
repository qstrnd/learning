/*:
 [133. Clone Graph](https://leetcode.com/problems/clone-graph/description/)
 
 #### Solution
 
 Use deep first search and a hash table to keep track of the nodes that has been copied.
 
 - **Time Complexity**: _O(n)_
 - **Space Complexity**: _O(n)_
 
 */

public class Node: Hashable {
    public var val: Int
    public var neighbors: [Node?]
    public init(_ val: Int) {
        self.val = val
        self.neighbors = []
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(neighbors)
    }
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.val == rhs.val && lhs.neighbors == rhs.neighbors
    }
}

class Solution {
    func cloneGraph(_ node: Node?) -> Node? {
        var clonedNodes: [Node: Node] = [:]

        func dfs(_ node: Node?) -> Node? {
            guard let node = node else { return nil }

            if let copy = clonedNodes[node] {
                return copy
            }
            
            let copy = Node(node.val)
            clonedNodes[node] = copy
            for n in node.neighbors {
                copy.neighbors.append(dfs(n))
            }

            return copy
        }

        return dfs(node)
    }
}

// MARK: - Tests

// I lacked time to write a decent test for graphs so I suggest running this code on LeetCode

//: [Previous](@previous) || [Next](@next)
