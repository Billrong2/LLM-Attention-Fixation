/// 
func f(nums: [Int]) -> [Int] {
    var numsCopy = nums
    let count = numsCopy.count
    while numsCopy.count > count / 2 {
        numsCopy.removeAll()
    }
    return numsCopy
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
            
assert(f(nums: [2, 1, 2, 3, 1, 6, 3, 8]) == [] as [Int])
