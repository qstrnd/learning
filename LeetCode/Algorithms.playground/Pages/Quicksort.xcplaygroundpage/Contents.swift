//: [Previous](@previous)

import Foundation

extension Array where Element: Comparable {
    
    mutating func quickSort(){
        _quickSort(from: startIndex, to: endIndex)
    }
    
    private mutating func _quickSort(from low: Index, to high: Index){
        guard low < high else { return }
        
        let p = _partition(from: low, to: high)
        _quickSort(from: low, to: p)
        _quickSort(from: p + 1, to: high)
    }
    
    private mutating func _partition(from low: Index, to high: Index) -> Int {
        var i = low
        let p = high - 1
        
        for j in low ..< high {
            if self[j] < self[p] {
                swapAt(i, j)
                i += 1
            }
        }
        
        swapAt(i, p)
        
        return i
    }
}

var a = [1, 3, 4, 5, 2, 5, 6, 7, 2, 3, 4, 5, 6, 5]
a.quickSort()

//: [Next](@next)
