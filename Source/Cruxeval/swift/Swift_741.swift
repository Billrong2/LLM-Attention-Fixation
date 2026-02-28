/// 
func f(nums: [Int], p: Int) -> Int {
    var prev_p = p - 1
    if prev_p < 0 {
        prev_p = nums.count - 1
    }
    return nums[prev_p]
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
            
assert(f(nums: [6, 8, 2, 5, 3, 1, 9, 7], p: 6) == 1)
