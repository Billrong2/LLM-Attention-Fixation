/// 
func f(nums: [Int]) -> [Int] {
    var count = 1
    var nums = nums
    for i in stride(from: count, to: nums.count - 1, by: 2) {
        nums[i] = max(nums[i], nums[count-1])
        count += 1
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
            
assert(f(nums: [1, 2, 3]) == [1, 2, 3])
