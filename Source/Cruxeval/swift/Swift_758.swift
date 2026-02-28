/// 
func f(nums: [Int]) -> Bool {
    if nums.reversed() == nums {
        return true
    }
    return false
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
            
assert(f(nums: [0, 3, 6, 2]) == false)
