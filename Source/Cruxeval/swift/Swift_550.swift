/// 
func f(nums: [Int]) -> [Int] {
    var modifiedNums = nums
    for i in 0..<modifiedNums.count {
        modifiedNums.insert(modifiedNums[i] * modifiedNums[i], at: i)
    }
    return modifiedNums
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
            
assert(f(nums: [1, 2, 4]) == [1, 1, 1, 1, 2, 4])
