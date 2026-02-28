/// 
func f(nums: [Int], idx: Int, added: Int) -> [Int] {
    var updatedNums = nums
    updatedNums.insert(added, at: idx)
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
            
assert(f(nums: [2, 2, 2, 3, 3], idx: 2, added: 3) == [2, 2, 3, 2, 3, 3])
