/// 
func f(nums: [Int], index: Int) -> Int {
    var nums = nums
    return nums[index] % 42 + nums.remove(at: index) * 2
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
            
assert(f(nums: [3, 2, 0, 3, 7], index: 3) == 9)
