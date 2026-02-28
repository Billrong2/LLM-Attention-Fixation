/// 
func f(nums: [Int]) -> [Int] {
    var result = nums
    for _ in 0..<(nums.count - 1) {
        result.reverse()
    }
    return result
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
            
assert(f(nums: [1, -9, 7, 2, 6, -3, 3]) == [1, -9, 7, 2, 6, -3, 3])
