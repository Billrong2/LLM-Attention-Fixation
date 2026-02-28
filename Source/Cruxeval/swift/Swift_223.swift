/// 
func f(array: [Int], target: Int) -> Int {
    var count = 0, i = 1
    for j in 1..<array.count {
        if array[j] > array[j - 1] && array[j] <= target {
            count += i
        } else if array[j] <= array[j - 1] {
            i = 1
        } else {
            i += 1
        }
    }
    return count
}


func ==(left: [(Int, Int)], right: [(Int, Int)]) -> Bool {
    if left.count != right.count {
        return false
    }
    for (l, r) in zip(left, right) {
        if l != r {
            return false
        }
    }
    return true
}
            
assert(f(array: [1, 2, -1, 4], target: 2) == 1)
