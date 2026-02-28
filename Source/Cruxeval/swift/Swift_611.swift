/// 
func f(nums: [Int]) -> [Int] {
    var reversedNums = nums.reversed()
    return Array(reversedNums)
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
            
assert(f(nums: [-6, -2, 1, -3, 0, 1]) == [1, 0, -3, 1, -2, -6])
