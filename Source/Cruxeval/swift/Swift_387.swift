/// 
func f(nums: [Int], pos: Int, value: Int) -> [Int] {
    var updatedNums = nums
    updatedNums.insert(value, at: pos)
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
            
assert(f(nums: [3, 1, 2], pos: 2, value: 0) == [3, 1, 0, 2])
