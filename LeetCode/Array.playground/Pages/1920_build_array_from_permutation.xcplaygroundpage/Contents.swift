/*:
 [1920. Build array from permutation](https://leetcode.com/problems/build-array-from-permutation/description/)
 
 #### Solution 1
 
 1. Naive is just to walk through array and append the elements following the rules in the description
  
 **Time complexity**: _O(n)_, where n is the length of nums
 **Space complexity**: _O(n)_, where n is the length of nums
 
 2. There's a smarter solution that is explained in detail  [here](https://leetcode.com/problems/build-array-from-permutation/solutions/1315926/python-o-n-time-o-1-space-w-full-explanation).
 
 I'll [a comment from Fulton Byrne](https://leetcode.com/problems/build-array-from-permutation/solutions/1315926/python-o-n-time-o-1-space-w-full-explanation/comments/1360114) for short explanation:
 
 > The intuition here is that if you can find some function to encode both the new value and the old value into the same value you can reach O(1) space. a = qb + r is great because you can encode the old value in the remainder (r), and the new value into b. Old value is retrievable by taking the remainder, new value is available by using a//q to access b.
 
 */

import Foundation

class Solution_Naive {
    func buildArray(_ nums: [Int]) -> [Int] {
        var i = 0
        var res: [Int] = []
        while i < nums.count {
            res.append(nums[nums[i]])
            i += 1
        }
        return res
    }
}

class Solution {
    func buildArray(_ nums: [Int]) -> [Int] {
        var nums = nums
        let q = nums.count
        for (i, c) in nums.enumerated() {
            nums[i] += q * (nums[c] % q)
        }
        for (i, _) in nums.enumerated() {
            nums[i] = nums[i] / q
        }
        return nums
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()
    
    assert(solution.buildArray([0,2,1,5,3,4]) == [0,1,2,4,5,3], "Test failed: buildArray([0,2,1,5,3,4]) == [0,1,2,4,5,3]")
    print("Test passed: buildArray([0,2,1,5,3,4]) == [0,1,2,4,5,3]")
    
    assert(solution.buildArray([5,0,1,2,3,4]) == [4,5,0,1,2,3], "Test failed: buildArray([5,0,1,2,3,4]) == [4,5,0,1,2,3]")
    print("Test passed: buildArray([5,0,1,2,3,4]) == [4,5,0,1,2,3]")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
