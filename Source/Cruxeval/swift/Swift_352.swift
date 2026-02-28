/// 
func f(nums: [Int]) -> Int {
    return nums[nums.count/2]
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
            
assert(f(nums: [-1, -3, -5, -7, 0]) == -5)
