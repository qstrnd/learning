/*:
 [1512. Number of good pairs](https://leetcode.com/problems/number-of-good-pairs/description/)
 
 #### Solution
 
 1. First thing that may come to mind is just to compair each pair. It would work but it would be almost _O(n^2)_ in complexity,
 because each element would be compaired with all elements that follow it.
 
 2. A more optimal solution is to calculate how many equal numbers are present in the array. We can do this with a hash table,
 since we have the constraint that `1 <= nums[i] <= 100`, we don't have to utilize a lot of memory.
 
 After we got the number of pairs, the combination formula can be applied and the number of pairs needs to be summed.
 
 ![Example GIF](1512_combination_formula.png)
 
 3. There's also a [solution](https://leetcode.com/problems/number-of-good-pairs/solutions/1154018/swift-number-of-good-pairs) where the number of pair is calculated on the go, eliminating the need for a second cycle. Both solutions 2 and 3 have the same O(n) time complexity and O(1) space complexity.
 
 - **Time Complexity**: _O(n)_, where n is the length of the input string s
 - **Space Complexity**: _O(1)_

 */

import Foundation

final class Solution_2Cycles {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        var vals: [Int: Int] = [:]

        for n in nums {
            let count = vals[n, default: 0]
            vals[n] = count + 1
        }

        var sum = 0
        for (num, count) in vals {
            sum += count * (count - 1) / 2
        }

        return sum
    }
}

final class Solution {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        var res = 0
        var count: [Int:Int] = [:]
        
        for num in nums {
            res += count[num, default: 0]
            count[num, default: 0] += 1
        }
        
        return res
    }
}


// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.numIdenticalPairs([1,2,3,1,1,3]) == 4, "Test failed: numIdenticalPairs([1,2,3,1,1,3]) == 4")
    print("Test passed: numIdenticalPairs([1,2,3,1,1,3]) == 4")
    
    assert(solution.numIdenticalPairs([1, 1, 1, 1]) == 6, "Test failed: numIdenticalPairs([1, 1, 1, 1]) == 6")
    print("Test passed: numIdenticalPairs([1, 1, 1, 1]) == 6")
    
    assert(solution.numIdenticalPairs([1, 2, 3]) == 0, "Test failed: numIdenticalPairs([1, 2, 3]) == 0")
    print("Test passed: numIdenticalPairs([1, 2, 3]) == 0")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
