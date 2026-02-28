/// 
func f(nums: [Int], spot: Int, idx: Int) -> [Int] {
    var updatedNums = nums
    updatedNums.insert(idx, at: spot)
    return updatedNums
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
            
assert(f(nums: [1, 0, 1, 1], spot: 0, idx: 9) == [9, 1, 0, 1, 1])
