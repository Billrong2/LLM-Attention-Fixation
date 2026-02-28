/// 
func f(nums: [Int]) -> [Int] {
    var nums = nums
    let m = nums.max() ?? 0
    for _ in 0..<m {
        nums.reverse()
    }
    return nums
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
            
assert(f(nums: [43, 0, 4, 77, 5, 2, 0, 9, 77]) == [77, 9, 0, 2, 5, 77, 4, 0, 43])
