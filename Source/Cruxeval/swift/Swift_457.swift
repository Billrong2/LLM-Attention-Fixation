func f(nums: [Int]) -> [Int] {
    var nums = nums
    var count = Array(0..<nums.count)
    for i in 0..<nums.count {
        nums.remove(at: 0)
        if count.count > 0 {
            count.remove(at: 0)
        }
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
            
assert(f(nums: [3, 1, 7, 5, 6]) == [] as [Int])
