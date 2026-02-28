/// 
func f(nums: [Int]) -> [Int] {
    var sortedNums = nums.sorted()
    return sortedNums
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
            
assert(f(nums: [-6, -5, -7, -8, 2]) == [-8, -7, -6, -5, 2])
