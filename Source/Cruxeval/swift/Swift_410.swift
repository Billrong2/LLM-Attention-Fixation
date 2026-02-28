func f(nums: [Int]) -> [Int] {
    var nums = nums
    for i in 0..<nums.count {
        nums.insert(nums[i], at: i)
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
            
assert(f(nums: [1, 3, -1, 1, -2, 6]) == [1, 1, 1, 1, 1, 1, 1, 3, -1, 1, -2, 6])
