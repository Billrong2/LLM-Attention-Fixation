/// 
func f(nums: [Int]) -> [Int] {
    var updatedNums = nums
    for i in 0..<updatedNums.count {
        updatedNums.insert(updatedNums[i]*2, at: i)
    }
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
            
assert(f(nums: [2, 8, -2, 9, 3, 3]) == [4, 4, 4, 4, 4, 4, 2, 8, -2, 9, 3, 3])
