/*:
 [15. 3Sum](https://leetcode.com/problems/3sum/description/)
 
 #### Solution
 
 We don't need indices, that's why we can sort the array and just solve the problem 2 sum II for every to find a matching couple of elements for every given element.
 
 **Time complexity**: _O(n^2)_, where n is the length of the array. Sorting takes _O(n logn)_, and the two-pointer approach for each element takes _O(n)_.
 **Space complexity**: _O(1)_

 */

import Foundation

final class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let target = 0
        var nums = nums.sorted()
        var result: [[Int]] = []
        
        for c in 0 ..< nums.count {
            if c > 0 && nums[c] == nums[c - 1] {
                continue
            }

            var i = c + 1
            var j = nums.count - 1

            while i < j {
                let sum = nums[c] + nums[i] + nums[j]
                if sum == target {
                    result.append([nums[c], nums[i], nums[j]])
                    repeat {
                        i += 1
                    } while (nums[i] == nums[i - 1] && i < j)
                } else if sum > target {
                    repeat {
                        j -= 1
                    } while (nums[j] == nums[j + 1] && j > i)
                } else {
                    repeat {
                        i += 1
                    } while (nums[i] == nums[i - 1] && i < j)
                }
            }
        }

        return result
    }
}

// MARK: - Tests

func testSolution() {
    let solution = Solution()

    assert(solution.threeSum([-1,0,1,2,-1,-4]) == [[-1,-1,2],[-1,0,1]], "Test failed: threeSum([-1,0,1,2,-1,-4]) == [[-1,-1,2],[-1,0,1]]")
    print("Test passed: threeSum([-1,0,1,2,-1,-4]) == [[-1,-1,2],[-1,0,1]]")
    
    assert(solution.threeSum([0,1,1]) == [], "Test failed: threeSum([0,1,1]) == [])")
    print("Test passed: threeSum([0,1,1]) == [])")
    
    assert(solution.threeSum([0,0,0]) == [[0, 0, 0]], "Test failed: threeSum([0,0,0]) == [0, 0, 0])")
    print("Test passed: threeSum([0,0,0]) == [0, 0, 0])")
}

testSolution()

//: [Previous](@previous) || [Next](@next)
