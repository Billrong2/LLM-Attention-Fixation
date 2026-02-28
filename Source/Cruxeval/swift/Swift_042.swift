func f(nums: [Int]) -> [Int] {
    var nums = nums
    nums.removeAll()
    for num in nums {
        nums.append(num * 2)
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
            
assert(f(nums: [4, 3, 2, 1, 2, -1, 4, 2]) == [] as [Int])
