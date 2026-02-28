/// 
func f(nums: [Int], mos: [Int]) -> Bool {
    var numsCopy = nums
    for num in mos {
        numsCopy.remove(at: numsCopy.firstIndex(of: num)!)
    }
    numsCopy.sort()
    for num in mos {
        numsCopy.append(num)
    }
    for i in 0..<(numsCopy.count - 1) {
        if numsCopy[i] > numsCopy[i + 1] {
            return false
        }
    }
    return true
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
            
assert(f(nums: [3, 1, 2, 1, 4, 1], mos: [1]) == false)
