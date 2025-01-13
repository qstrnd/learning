/*:
 [1470. Shuffle the Array](https://leetcode.com/problems/shuffle-the-array/description/)
 
 #### Solution

 */

import Foundation

final class Solution_MemoryOptimized {
    func shuffle(_ nums: inout [Int], _ n: Int) -> [Int] {
        var i = 0
        var j = 0
        var k = n
        let q = 1001

        while i < 2 * n {
            if i % 2 == 0 {
                nums[i] += nums[j] % q * q
                j += 1
            } else {
                nums[i] += nums[k] % q * q
                k += 1
            }
            i += 1
        }

        i = 0
        while i < 2 * n {
            nums[i] = nums[i] / q
            i += 1
        }

        return nums
    }
}

final class Solution {
    func shuffle(_ nums: [Int], _ n: Int) -> [Int] {
        var nums = nums
        var i = 0
        var j = 0
        var k = n
        let q = 1001

        while i < 2 * n {
            if i % 2 == 0 {
                nums[i] += nums[j] % q * q
                j += 1
            } else {
                nums[i] += nums[k] % q * q
                k += 1
            }
            i += 1
        }

        i = 0
        while i < 2 * n {
            nums[i] = nums[i] / q
            i += 1
        }

        return nums
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution_MemoryOptimized()
    
    var arr = [2,5,1,3,4,7]
    solution.shuffle(&arr, 3)
    assert(arr == [2,3,5,4,1,7], "Test failed: shuffle([2,5,1,3,4,7], 3) == [2,3,5,4,1,7]")
    print("Test passed: shuffle([2,5,1,3,4,7], 3) == [2,3,5,4,1,7]")
    
    arr = [1,2,3,4,4,3,2,1]
    solution.shuffle(&arr, 4)
    assert(arr == [1,4,2,3,3,2,4,1], "Test failed: shuffle([1,2,3,4,4,3,2,1], 4) == [1,4,2,3,3,2,4,1]")
    print("Test passed: shuffle([1,2,3,4,4,3,2,1], 4) == [1,4,2,3,3,2,4,1]")
}

testSolution()


//: [Previous](@previous) || [Next](@next)
