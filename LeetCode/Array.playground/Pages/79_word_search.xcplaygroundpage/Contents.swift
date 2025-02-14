/*:
 [79. Word Search](https://leetcode.com/problems/word-search/description/)
 
 #### Solution
 
 Iterate through each element and try to find if the current character matched the word. If it does,
 iteratively go to the neighboring greed items and proceed if they match the next character.
 
 **Time complexity**: _O(n*m*4^l)_, where n is the width, m is the height of the board and k is the length of the word
 **Space complexity**: _O(k)_

 */

import Foundation

final class Solution {
    private struct P: Hashable {
        let i: Int
        let j: Int
    }

    func exist(_ board: [[Character]], _ word: String) -> Bool {
        var height = board.count
        var width = board[0].count
        var isFound = false

        func step(i: Int, j: Int, charsLeft: String, visited: Set<P> = []) {
            let char = String(charsLeft.prefix(1))
            guard String(board[i][j]) == char else { return }

            var visited = visited
            visited.insert(P(i: i, j: j))
            
            let charsLeft = String(charsLeft.dropFirst())

            guard !charsLeft.isEmpty else {
                isFound = true
                return
             }

            let dirs = [(0, -1), (0, 1), (-1, 0), (1, 0)]
            for (di, dj) in dirs {
                let newI = i + di
                let newJ = j + dj
                guard newI >= 0 && newI < height && newJ >= 0 && newJ < width else {
                    continue
                }
                guard !visited.contains(P(i: newI, j: newJ)) else {
                    continue
                }
                
                step(i: newI, j: newJ, charsLeft: charsLeft, visited: visited)
            }
        }

        for i in 0 ..< height {
            for j in 0 ..< width {
                step(i: i, j: j, charsLeft: word)
                if isFound {
                    return true
                }
            }
        }
        
        return isFound
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(
        solution.exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCCED"),
        "Test failed: exist([[\"A\",\"B\",\"C\",\"E\"],[\"S\",\"F\",\"C\",\"S\"],[\"A\",\"D\",\"E\",\"E\"]]) == false"
    )
    print("Test passed: exist([[\"A\",\"B\",\"C\",\"E\"],[\"S\",\"F\",\"C\",\"S\"],[\"A\",\"D\",\"E\",\"E\"]]) == false")
    
    assert(
        solution.exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "SEE"),
        "Test failed: exist([[\"A\",\"B\",\"C\",\"E\"],[\"S\",\"F\",\"C\",\"S\"],[\"A\",\"D\",\"E\",\"E\"]]) == true"
    )
    print("Test passed: exist([[\"A\",\"B\",\"C\",\"E\"],[\"S\",\"F\",\"C\",\"S\"],[\"A\",\"D\",\"E\",\"E\"]]) == true")
    
    assert(
        solution.exist([["a"]], "a"),
        "Test failed: exist([[\"a\"]]) == true"
    )
    print("Test passed: exist([[\"a\"]]) == true")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
